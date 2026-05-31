{ pkgs, ... }:

{
  programs.nix-ld.enable = true;

  programs.pi.coding-agent.enable = true;

  environment.systemPackages = with pkgs; [
    clang
    llvm
    nodejs
  ];
}
