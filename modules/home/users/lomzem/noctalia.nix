{ inputs, pkgs, ... }:

let
  configDir = ./noctalia/config;
in
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  home.packages = with pkgs; [
    cliphist
  ];

  programs.noctalia-shell = {
    enable = true;
    settings = builtins.fromJSON (builtins.readFile "${configDir}/settings.json");
    colors = builtins.fromJSON (builtins.readFile "${configDir}/colors.json");
    plugins = builtins.fromJSON (builtins.readFile "${configDir}/plugins.json");
    user-templates = "${configDir}/user-templates.toml";
  };

  xdg.configFile = {
    "noctalia/colorschemes".source = "${configDir}/colorschemes";
    "noctalia/templates".source = "${configDir}/templates";
  };
}
