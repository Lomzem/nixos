{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Lawjay Lee";
        email = "lawjaylee1@icloud.com";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
