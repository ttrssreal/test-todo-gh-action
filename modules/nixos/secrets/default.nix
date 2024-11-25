{ config
, pkgs
, util
, lib
, inputs
, hostname
, ...
}: let
  cfg = config.secrets;
in {
  imports = with inputs; [
    agenix.nixosModules.default
  ];

  options.secrets = {
    keyPath = lib.mkOption {
      description = ''
        The path of the host key
      '';
      type = lib.types.str;
      default = "/etc/ssh/ssh_host_key";
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

  config = {
    age = {
      identityPaths = [ cfg.keyPath ];
      secrets = let
        secretFiles = setPath: builtins.mapAttrs (name: secret:
          secret // { file = util.root (setPath name); }
        );
        shared = secretFiles (secret: "/secrets/${secret}.age") cfg.shared;
        private = secretFiles
          (secret: "/hosts/${hostname}/secrets/${secret}.age") cfg.private;
      in shared // private;
    };

    system.activationScripts = let
      path = cfg.keyPath;
    in {
      # generate a new private key (initially will fail the verify step)
      genKey.text = ''
        if ! [ -s "${path}" ]; then
            if ! [ -h "${path}" ]; then
                rm -f "${path}"
            fi
            mkdir -p "$(dirname '${path}')"
            chmod 0755 "$(dirname '${path}')"
            ${pkgs.openssh}/bin/ssh-keygen \
                -t "ed25519" \
                -f "${path}" \
                -N ""
        fi
      '';

      # generate the pub key then check it maches the one we have
      verifyKey.text = let
        pubKeyRaw = builtins.readFile cfg.pubKeyFile;
        pubKey = lib.trim pubKeyRaw;
        expected = lib.escapeShellArg pubKey;
      in ''
        derived="$(${pkgs.openssh}/bin/ssh-keygen -y -f ${path})"
        expected=${expected}
        if [ "$derived" != "$expected" ]; then
          echo "Key content mismatch for ${path}"
          echo "Expected: $expected"
          echo "Got:      $derived"
          exit 1
        fi
      '';
    };
  };
}
