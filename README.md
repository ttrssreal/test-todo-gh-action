## nix-config

### Notes

#### Environment

Run `nix develop` for a devShell, `nix-shell` should also work.

#### Hosts
 - laptop: `jess-laptop`
 - k8s-node `ari`
 - desktop (for now) `server`

#### Building on nixos
In the flakes root directory:

### Build
`$ make build-<hostname>`

example: `$ make build-ari`

### Build and switch
`$ make <hostname>`

example: `$ make ari`
