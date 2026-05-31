validate:
    git add -A && nix flake check --extra-experimental-features 'flakes nix-command'
