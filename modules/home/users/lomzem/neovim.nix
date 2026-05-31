{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = true;
    withRuby = true;
  };

  home.packages = with pkgs; [
    basedpyright
    clang-tools
    lua-language-server
    prettier
    ruff
    stylua
    svelte-language-server
    tailwindcss-language-server
    tex-fmt
    texlab
    texlive.combined.scheme-medium
    tinymist
    tombi
    typst
    typescript-go
    vscode-langservers-extracted
    yazi
  ];

  xdg.configFile.nvim = {
    source = ./neovim-config;
    recursive = true;
    force = true;
  };
}
