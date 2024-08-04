{ pkgs
, inputs
, flakeDir
}:
(import ./misc.nix { inherit pkgs; }) ++
(import ./personal.nix { inherit pkgs inputs flakeDir; })
