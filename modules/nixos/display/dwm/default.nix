{ pkgs
, lib
, config
, ...
}: let
  cfg = config.programs.dwm;
in {
  options = {
    programs.dwm.useDmenu = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = {
    jess.hasDisplay = true;
    services.xserver = {
      enable = true;
      xkb.layout = "nz";
      windowManager.dwm = {
        enable = true;
        package = pkgs.dwm.overrideAttrs (_: prevAttrs: {
          src = pkgs.fetchFromGitHub {
            owner = "ttrssreal";
            repo = "dwm";
            rev = "44b583e4240569d97115bed21d0b7c1d0a1272ba";
            hash = "sha256-T3j2WuPYH80CM/O9Lz/hI1TrZKeJ+DL87jBTXxlOryk=";
          };

          buildInputs = prevAttrs.buildInputs ++ [ pkgs.dbus ];

          nativeBuildInputs = [ pkgs.pkg-config ];
        });
      };
    };

    environment.systemPackages = lib.mkIf cfg.useDmenu [ pkgs.dmenu ];
  };
}
