{ pkgs
, lib
, config
, ...
}:
let
  cfg = config.jess.bt-con;
in {
  options = {
    jess.bt-con.deviceAddrs = lib.mkOption {
      type = with lib.types; attrsOf str;
      default = {};
    };
  };

  config = {
    home.packages = [
      pkgs.bt-con
    ];

    # mappings for bt-con
    # icon/name -> mac addr
    xdg.configFile."bt-con/map".text =
      builtins.concatStringsSep "\n" (
        lib.mapAttrsToList
          (k: v: "${k}\t${v}")
          cfg.deviceAddrs
      );
  };
}
