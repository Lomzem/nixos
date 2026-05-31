{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "root"
        "lomzem"
      ];
      substituters = [
        "https://cache.nixos.org"
        "https://niri.cachix.org"
      ];
      trusted-public-keys = [
        "niri.cachix.org-1:EvNL3D/X6QJ5PpxhAE94wxR8tRJq9jwjJ8yYxZMQ2Ns="
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  system.autoUpgrade = {
    enable = true;
    flake = "/home/lomzem/coding/nixos#desktop";
    flags = [ "--update-input" "nixpkgs" ];
    dates = "weekly";
    randomizedDelaySec = "45min";
  };

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";

  networking.networkmanager.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  hardware.enableRedistributableFirmware = true;

  programs.fish.enable = true;

  users.users.lomzem = {
    isNormalUser = true;
    description = "Lawjay Lee";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    shell = pkgs.fish;
  };

  security.sudo.extraRules = [
    {
      users = [ "lomzem" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  environment.systemPackages = with pkgs; [
    git
    vim
  ];

  system.stateVersion = "25.11";
}
