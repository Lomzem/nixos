{ inputs, pkgs, ... }:

{
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  security.rtkit.enable = true;
}
