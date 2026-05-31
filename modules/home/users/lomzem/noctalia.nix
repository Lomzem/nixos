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
    "noctalia/colors.json".force = true;
    "noctalia/colorschemes" = {
      force = true;
      source = "${configDir}/colorschemes";
    };
    "noctalia/plugins.json".force = true;
    "noctalia/settings.json".force = true;
    "noctalia/templates" = {
      force = true;
      source = "${configDir}/templates";
    };
  };
}
