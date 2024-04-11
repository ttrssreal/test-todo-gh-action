## nix-config

### Notes

#### Environment

Run `nix develop` for a devShell, `nix-shell` should also work.

#### Hosts
* Laptop: `jess-laptop`

#### Building on nixos
In the flakes root directory:

`$ nixos-rebuild switch --flake .#<hostname>`