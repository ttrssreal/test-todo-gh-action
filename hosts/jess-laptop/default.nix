{ lib
, inputs
, hostname
, extraModules
, util
, ...
}: lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = {
    inherit util inputs hostname;
  };
  modules = [
    ./system.nix
    ../common
  ] ++ extraModules;
}
