# Secrets

This directory is reserved for `sops-nix` encrypted secrets.

No real secrets are stored yet. When ready, generate an age key on the target
machine at `/var/lib/sops-nix/key.txt`, configure `.sops.yaml`, and replace
`secrets.yaml` with an encrypted SOPS file.
