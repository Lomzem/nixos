validate:
    git add -A && nix flake check --extra-experimental-features 'flakes nix-command'

home:
    git add -A && nix build .#nixosConfigurations.desktop.config.home-manager.users.lomzem.activationPackage --extra-experimental-features 'flakes nix-command' && ./result/activate
