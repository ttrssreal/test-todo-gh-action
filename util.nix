{ lib
, inputs
, util
, ...
}: let
  filterUsers = predicate: let
      users = builtins.map
        (name: ./. + "/users/${name}")
        (builtins.attrNames (builtins.readDir ./users));
    in
      builtins.filter predicate users;

  hostHasUser = hostname: user:
    builtins.hasAttr hostname (builtins.readDir (user + /hosts));

  getUsersForHost = hostname:
    filterUsers (hostHasUser hostname);
in rec {
  root = path: ./. + path;
  pathFrom = root: path: root + path;
  pathsFrom = root: paths:
    builtins.map (path: root + path) paths;
  hmModule = path:
    pathFrom (root /modules/hm) path;
  hmModules = paths:
    builtins.map hmModule paths;
  nixosModule = path:
    pathFrom (root /modules/nixos) path;
  nixosModules = paths:
    builtins.map nixosModule paths;

  pkgsConfig = {
    allowUnfree = true;
  };

  getHost =
    hostname: ./. + "/hosts/${hostname}";

  getUser =
    username: ./. + "/users/${username}";

  mkHost =
    hostname: users: let
      userModules = builtins.map getUser users;
      markerModule = root /modules/marker.nix;
      host = getHost hostname;
    in {
      ${hostname} = import host {
        extraModules =
          userModules ++ [ markerModule ];

        inherit lib util inputs hostname;
      };
    };

  mkDevShell =
    nixpkgs: system: import ./shell.nix {
      pkgs = import nixpkgs { inherit system; };
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
