{ inputs, pkgs, ... }:

{
  imports = [
    inputs.helium.homeModules.default

    ./fish.nix
    ./git.nix
    ./neovim.nix
    ./noctalia.nix
    ./niri.nix
    ./rio.nix
    ./ssh.nix
  ];

  home = {
    username = "lomzem";
    homeDirectory = "/home/lomzem";
    stateVersion = "25.11";

    file.".pi/agent/settings.json" = {
      force = true;
      text = builtins.toJSON {
        lastChangelogVersion = "0.78.0";
        defaultProvider = "openai-codex";
        defaultModel = "gpt-5.5";
        hideThinkingBlock = false;
        theme = "dark";
        defaultThinkingLevel = "low";
        enabledModels = [
          "openai-codex/gpt-5.4-mini"
          "openai-codex/gpt-5.5"
        ];
        packages = [
          "git:github.com/arpagon/pi-rewind@91611ad87992fb7b635a41ba68f67916ff6e6ae3"
        ];
      };
    };

    packages = [
    ] ++ (with pkgs; [
      bun
      curl
      fd
      fzf
      gh
      git
      go
      just
      llvm
      nodejs
      opencode
      python3
      ripgrep
      rustup
      vesktop
      wget
    ]);
  };

  home.enableNixpkgsReleaseCheck = false;

  programs.helium = {
    enable = true;
    flags = [
      "--ozone-platform-hint=auto"
    ];
  };

  programs.home-manager.enable = true;
}
