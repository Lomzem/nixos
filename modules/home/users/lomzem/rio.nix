{ pkgs, ... }:

{
  programs.rio = {
    enable = true;
    package = pkgs.rio;
  };

  xdg.configFile = {
    "rio/config.toml".source = ./rio/config.toml;
    "rio/themes/catppuccin-mocha.toml".source = ./rio/themes/catppuccin-mocha.toml;
  };
}
