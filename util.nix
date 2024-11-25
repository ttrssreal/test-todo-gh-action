{ lib
, inputs
, util
, ...
}: rec {
  root = path: ./. + path;
  pathFrom = root: path: root + path;
  pathsFrom = root: paths:
    builtins.map (path: root + path) paths;
  hmModule = pathFrom (root /modules/hm);
  hmModules = builtins.map hmModule;
  nixosModule = pathFrom (root /modules/nixos);
  nixosModules = builtins.map nixosModule;

  pkgsConfig = {
    allowUnfree = true;
  };

  mkHost = hostname: users: lib.nixosSystem {
    # system = lib.traceVal (import (./. + "/hosts/${hostname}") {});
    system = "x86_64-linux";
    specialArgs = {
      inherit util inputs hostname;
    };
    modules = lib.flatten [
      (./. + "/hosts/${hostname}")
      users
      ./hosts/base.nix
    ];
  };

  mkUserAtHost = hostname: host: username: _: {
    "${username}@${hostname}" =
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit (host) pkgs;
        inherit (host.config.home-manager) extraSpecialArgs;
        modules = [
          (./. + "/users/${username}/env/${hostname}")
          # for standalone
          # https://nix-community.github.io/home-manager/options.xhtml#opt-nix.package
          { nix.package = inputs.nixpkgs.legacyPackages.${host.pkgs.system}.nix; }
        ];
      };
  };

  mkOverlay = overlay: {
    nixpkgs.overlays = [ overlay ];
  };

  mkDevShell =
    nixpkgs: system: import ./shell.nix {
      pkgs = import nixpkgs { inherit system; };
      inherit inputs;
    };

  mkDevShells =
    nixpkgs: systems: let
      devShellMapper =
        system: { default = mkDevShell nixpkgs system; };
    in
      listToAttrs lib.trivial.id devShellMapper systems;

  listToAttrs =
    keyMapper: valueMapper: list: let
      attrsMapper = item: {
        name = keyMapper item;
        value = valueMapper item;
      };
    in
      builtins.listToAttrs (builtins.map attrsMapper list);
}
