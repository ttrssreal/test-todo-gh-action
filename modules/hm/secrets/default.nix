{ lib
, config
, util
, inputs
, ...
}: let
  cfg = config.secrets;
in {
  imports = with inputs; [
    agenix.homeManagerModules.default
  ];

  options.secrets = {
    keyPath = lib.mkOption {
      type = lib.types.path;
      default = null;
    };

    pubKeyFile = lib.mkOption {
      type = lib.types.path;
      default = null;
    };

    shared = lib.mkOption {
      type = with lib.types; attrsOf attrs;
      default = {};
    };

    private = lib.mkOption {
      type = with lib.types; attrsOf attrs;
      default = {};
    };
  };

  config.age = {
    identityPaths = [ cfg.keyPath ];
    secrets = let
      secretFiles = setPath: builtins.mapAttrs (name: secret:
        secret // { file = util.root (setPath name); }
      );
      shared = secretFiles (secret: "/secrets/${secret}.age") cfg.shared;
      private = secretFiles
        (secret: "/users/${config.home.username}/secrets/${secret}.age")
        cfg.private;
    in shared // private;
  };
}
