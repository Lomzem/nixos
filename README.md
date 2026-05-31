# NixOS Flake

I use NixOS, btw.

## Git Submodules

```bash
git submodule update --init --recursive
git submodule update --remote
```

## Import Config

```bash
sudo nixos-rebuild switch --flake .#desktop
```
