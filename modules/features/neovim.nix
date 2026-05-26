{ self, pkgs, ... }: {
  flake.nixosModules.neovim = { pkgs, lib, ... }: {
    environment.systemPackages = with pkgs; [
      neovim
      ripgrep
      fd
      gcc
      lua-language-server
    ];
    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };
  };
}
