{ pkgs, ... }:

let
  fzfDefaultOpts = builtins.concatStringsSep "\n" [
    "--bind='ctrl-l:accept'"
    "--style full"
    "--height=~65%"
    "--layout=reverse"
    "--border=none"
    "--prompt='❯ '"
    "--pointer=''"
    "--marker=''"
    "--scrollbar=''"
    "--highlight-line"
    "--cycle"
    "--color='"
    "  fg:-1,fg+:-1,bg:-1,bg+:black"
    "  hl:cyan,hl+:bright-cyan"
    "  border:bright-black,separator:bright-black,scrollbar:bright-black"
    "  label:-1,query:-1"
    "  prompt:yellow,pointer:green,marker:yellow"
    "  spinner:yellow,info:bright-black"
    "  header:cyan,gutter:-1"
    "'"
  ];
in
{
  home = {
    packages = with pkgs; [
      atuin
      eza
      starship
      wl-clipboard
      zoxide
    ];

    sessionPath = [ "$HOME/.local/bin" ];

    sessionVariables = {
      CANVAS_URL = "https://canvas.csuchico.edu";
      EDITOR = "nvim";
      FZF_DEFAULT_OPTS = fzfDefaultOpts;
      LESS = "-R --use-color -Dd+r$Du+b";
      MANPAGER = "nvim +Man!";
      VISUAL = "nvim";
    };
  };

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      fish_vi_key_bindings insert

      if command --query dircolors
          set -gx LS_COLORS (dircolors | string replace -r '^LS_COLORS=' "" | string trim -c "'")
      end

      function ls --wraps eza
          eza $argv
      end
    '';

    shellAbbrs = {
      cdt = "cd (mktemp --directory)";
      cl = "clear";
      cls = "clear";
      gd = "nvim -c 'CodeDiff'";
      m = "make";
      mdt = "nvim (mktemp --suffix=.md) -c 'setlocal autowriteall'";
      oc = "opencode .";
      p = "wl-paste";
      pso = "source .venv/bin/activate.fish";
      r = "readlink -f";
      rs = "sudo reboot now";
      sd = "sudo shutdown now";
      vpn = "sudo gpclient --fix-openssl connect vpn-gw.csuchico.edu";
      z = "cd";

      n = "nvim";

      g = "git";
      gA = "git add -A";
      ga = "git add .";
      gc = "git commit";
      gco = "git checkout";
      gp = "git pull";
      gph = "git push";
      gs = "git status";
      jp = ''git add . && git commit -m "Just push 😝" && git push'';

      C = {
        position = "anywhere";
        expansion = "| wl-copy";
      };
      X = {
        position = "anywhere";
        expansion = "| xargs -I {}";
      };
    };

    functions = {
      enter_nvim = ''
        if string match (jobs --command) "nvim"
            fg
        else
            nvim .
        end
      '';

      fish_greeting = "";

      fish_user_key_bindings = ''
        bind -M default ctrl-n enter_nvim
        bind -M insert ctrl-n enter_nvim

        bind -M default ctrl-f search_coding repaint
        bind -M insert ctrl-f search_coding repaint

        bind -M default alt-k up-or-search
        bind -M insert alt-k up-or-search
        bind -M default alt-j down-or-search
        bind -M insert alt-j down-or-search

        bind -M default ctrl-o canvastui repaint
        bind -M insert ctrl-o canvastui repaint
      '';

      gcm = ''
        git commit -m "$argv"
      '';

      search_coding = ''
        set choices (fd --format {} -td . "$HOME/coding/" -d 1)

        set selected (
            printf "%s\n" $choices | \
            sort -r | \
            fzf --delimiter '/' --with-nth -2..
        )

        if test -n "$selected"
            cd $selected
        end
      '';

      so = ''
        source $HOME/.config/fish/config.fish
      '';
    };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      add_newline = true;
      format = "$python$directory$git_branch\n$character";

      directory = {
        style = "cyan";
        truncation_length = 2;
        truncation_symbol = "";
        fish_style_pwd_dir_length = 1;
      };

      git_branch = {
        format = " [$branch]($style)";
        style = "blue";
      };

      python = {
        format = ''[(\($virtualenv\) )]($style)'';
        style = "white";
      };
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    options = [ "--cmd cd" ];
  };
}
