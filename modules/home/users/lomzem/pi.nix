{ ... }:

{
  home.file.".pi/agent/extensions/quick-commit.ts" = {
    force = true;
    text = ''
      import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

      const COMMIT_PROVIDER = "openai-codex";
      const COMMIT_MODEL = "gpt-5.4-mini";
      const PROMPT = "Please stage all changes, then `git commit` everything with a conventional commit message and details in the commit body. Afterwards, `git push` it.";

      export default function (pi: ExtensionAPI) {
        let pending = false;
        let running = false;
        let restoreAfterRun: undefined | {
          model: any;
          thinkingLevel: ReturnType<typeof pi.getThinkingLevel>;
        };

        async function startQuickCommit(ctx: any) {
          const commitModel = ctx.modelRegistry.find(COMMIT_PROVIDER, COMMIT_MODEL);
          if (!commitModel) {
            ctx.ui.notify(`Model not found: ''${COMMIT_PROVIDER}/''${COMMIT_MODEL}`, "error");
            return;
          }

          restoreAfterRun = {
            model: ctx.model,
            thinkingLevel: pi.getThinkingLevel(),
          };

          const ok = await pi.setModel(commitModel);
          if (!ok) {
            restoreAfterRun = undefined;
            ctx.ui.notify(`Could not switch to ''${COMMIT_PROVIDER}/''${COMMIT_MODEL}; missing API key?`, "error");
            return;
          }

          pi.setThinkingLevel("off");
          running = true;
          ctx.ui.notify(`Quick commit queued with ''${COMMIT_PROVIDER}/''${COMMIT_MODEL} and thinking off`, "info");
          pi.sendUserMessage(PROMPT);
        }

        pi.registerShortcut("alt+c", {
          description: "Stage, commit, and push using gpt-5.4-mini with thinking off",
          handler: async (ctx) => {
            if (pending || running) {
              ctx.ui.notify("Quick commit is already pending/running", "warning");
              return;
            }

            if (!ctx.isIdle()) {
              pending = true;
              ctx.ui.notify("Quick commit will run after the current agent turn finishes", "info");
              return;
            }

            await startQuickCommit(ctx);
          },
        });

        pi.on("agent_end", async (_event, ctx) => {
          if (running) {
            running = false;

            const previous = restoreAfterRun;
            restoreAfterRun = undefined;

            if (previous?.model) {
              await pi.setModel(previous.model);
            }
            if (previous) {
              pi.setThinkingLevel(previous.thinkingLevel);
            }

            ctx.ui.notify("Quick commit finished; restored previous model and thinking level", "info");
            return;
          }

          if (pending) {
            pending = false;
            await startQuickCommit(ctx);
          }
        });
      }
    '';
  };
}
