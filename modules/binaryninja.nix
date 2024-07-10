{
  pkgs,
  flakeDir,
  ...
}:
let
  binaryninja = pkgs.callPackage (flakeDir + /pkgs/binaryninja.nix) {};
in {
  environment.systemPackages = [
    binaryninja
  ];
}
