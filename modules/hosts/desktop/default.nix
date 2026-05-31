{ inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops
    inputs.niri.nixosModules.niri
    inputs.pi.nixosModules.default

    ./hardware.nix
    ../../nixos/common.nix
    ../../nixos/boot.nix
    ../../nixos/desktop.nix
    ../../nixos/development.nix
    ../../nixos/docker.nix
    ../../nixos/nvidia.nix
    ../../nixos/sops.nix
    ../../home/lomzem.nix
  ];

  networking.hostName = "desktop";
}
