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
