{ pkgs, flakeDir, ... }:
let
  bt-con = pkgs.callPackage (flakeDir + /pkgs/bt-con.nix) {};
in {
  environment.systemPackages = [
    bt-con
  ];
}
