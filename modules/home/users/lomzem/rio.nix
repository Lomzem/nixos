{ pkgs, ... }:

{
  programs.rio = {
    enable = true;
    package = pkgs.rio;
  };

  xdg.configFile = {
    "rio/config.toml" = {
      force = true;
      source = ./rio/config.toml;
    };
    "rio/themes/catppuccin-mocha.toml" = {
      force = true;
      source = ./rio/themes/catppuccin-mocha.toml;
    };
  };
}
