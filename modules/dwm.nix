{ config, pkgs, ... }:
let
  cfg = config.programs.dwm;
  lib = pkgs.lib;
in {
  options.programs.dwm = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''Whether or not to enable dwm'';
    };

    use-fork = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''Whether or not to use custom fork'';
    };
  };

  config.services.xserver = lib.mkIf cfg.enable {
    enable = true;
    xkb = {
      layout = "nz";
      variant = "";
    };
    displayManager.startx.enable = true;
    windowManager.dwm = {
      enable = true;
      package = lib.mkIf cfg.use-fork (pkgs.dwm.overrideAttrs (_: prevAttrs: {
        src = fetchGit {
          url = "https://github.com/ttrssreal/dwm.git";
          rev = "6d5ebc0eb2413cc240c963c629d7bb724e944be2";
        };

        buildInputs = prevAttrs.buildInputs ++ [ pkgs.dbus ];

        nativeBuildInputs = [ pkgs.pkg-config ];
      }));
    };
  };
}
