{ pkgs, ... }:

{
  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    clang
    llvm
    nodejs
  ];
}
