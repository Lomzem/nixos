{ self, inputs, ... }: {
  flake.nixosModules.desktopConfiguration = { config, lib, pkgs, ... }:

  {
    imports =
      [ # Include the results of the hardware scan.
      self.nixosModules.desktopHardware
      self.nixosModules.niri
      ];

# Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "lomzem"; # Define your hostname.

# Configure network connections interactively with nmcli or nmtui.
      networking.networkmanager.enable = true;

# Set your time zone.
    time.timeZone = "America/Los_Angeles";

# Select internationalisation properties.
# i18n.defaultLocale = "en_US.UTF-8";
# console = {
#   font = "Lat2-Terminus16";
#   keyMap = "us";
#   useXkbConfig = true; # use xkb.options in tty.
# };

# Enable CUPS to print documents.
# services.printing.enable = true;

# Enable sound.
# services.pulseaudio.enable = true;
# OR
# services.pipewire = {
#   enable = true;
#   pulse.enable = true;
# };

# Enable touchpad support (enabled default in most desktopManager).
# services.libinput.enable = true;

    services.getty.autologinUser = "lomzem";

    programs.niri = {
      enable = true;
    };

# Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.lomzem = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
	packages = with pkgs; [
	tree
	];
    };

# programs.firefox.enable = true;

# List packages installed in system profile.
# You can use https://search.nixos.org/ to find more packages (and options).
    environment.systemPackages = with pkgs; [
      neovim
	wget
	kitty
	git
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    system.stateVersion = "25.11";
  };
		       }
