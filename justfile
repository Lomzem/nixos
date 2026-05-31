validate:
    git add -A && nix flake check --extra-experimental-features 'flakes nix-command'

home:
    git add -A && nix build --impure --extra-experimental-features 'flakes nix-command' --expr '(builtins.getFlake (toString ./.)).nixosConfigurations.desktop.config.home-manager.users.lomzem.home.activationPackage' && ./result/activate

build-desktop:
    sudo nixos-rebuild switch --flake .#desktop
