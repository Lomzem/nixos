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
    "noctalia/colorschemes/Catppuccin Lavender/Catppuccin Lavender.json" = {
      force = true;
      source = "${configDir}/colorschemes/Catppuccin Lavender/Catppuccin Lavender.json";
    };
    "noctalia/colorschemes/GitHub Dark/GitHub Dark.json" = {
      force = true;
      source = "${configDir}/colorschemes/GitHub Dark/GitHub Dark.json";
    };
    "noctalia/colorschemes/Oxocarbon/Oxocarbon.json" = {
      force = true;
      source = "${configDir}/colorschemes/Oxocarbon/Oxocarbon.json";
    };
    "noctalia/colorschemes/Poimandres/Poimandres.json" = {
      force = true;
      source = "${configDir}/colorschemes/Poimandres/Poimandres.json";
    };
    "noctalia/colorschemes/vague/vague.json" = {
      force = true;
      source = "${configDir}/colorschemes/vague/vague.json";
    };
    "noctalia/plugins.json".force = true;
    "noctalia/settings.json".force = true;
    "noctalia/templates/opencode.json" = {
      force = true;
      source = "${configDir}/templates/opencode.json";
    };
  };
}
