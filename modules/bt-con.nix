{ config, pkgs, flakeDir, ... }:
let
  cfg = config.programs.bt-con;
  bt-con = pkgs.callPackage (flakeDir + /pkgs/bt-con.nix) {};
  lib = pkgs.lib;
in {
  options.programs.bt-con.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = ''Whether or not to enable bt-con'';
  };

  config = {
    environment.systemPackages = lib.mkIf cfg.enable [
      bt-con
    ];
  };
}
