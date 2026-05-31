{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      alias = {
        a = "add";
        amend = "commit --amend";
        b = "branch";
        c = "clone";
        co = "checkout";
        d = "diff --cached";
        dc = "diff --cached";
        df = "diff";
        hist = "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short";
        last = "log -1 HEAD";
        p = "pull";
        ph = "push";
        r = "restore";
        show = "show --ext-diff";
        s = "status";
        u = "reset HEAD --";
        unstage = "reset HEAD --";
      };
      color.ui = "auto";
      core.pager = "bat";
      credential.helper = "store";
      diff = {
        external = "difft";
        tool = "difftastic";
      };
      push = {
        autoSetupRemote = true;
        default = "current";
      };
      user = {
        name = "Lawjay Lee";
        email = "lawjaylee1@icloud.com";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  home.packages = with pkgs; [
    bat
    difftastic
  ];
}
