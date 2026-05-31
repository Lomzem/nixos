# Nix Config AGENTS.md

## Nix Documentation

I cloned the official `nix` GitHub repository. It is located in
`@external-repos/nix`. Please reference it to learn more about Nix and modern
best practices.

## Completion Requirements

- After adding a code change, validate the config with the bash command: `just validate`

## Common Issues

- When running Nix CLI commands, you may need this flag: `--extra-experimental-features 'flakes nix-command'`
- Nix wants all changes to at least be **staged** in `git`. Please just `git add -A` just to appease it.
