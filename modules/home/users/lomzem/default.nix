{ inputs, pkgs, ... }:

{
  imports = [
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
      inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
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
      python3
      ripgrep
      rustup
      wget
    ]);
  };

  home.enableNixpkgsReleaseCheck = false;

  programs.home-manager.enable = true;
}
