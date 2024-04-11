{ inputs, config, pkgs, flakeDir, ... }:
let
  cfg = config.programs.status-bar;
  status-bar = pkgs.callPackage (flakeDir + /pkgs/status-bar.nix) {};
  lib = pkgs.lib;
in {
  options.programs.status-bar.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = ''Whether or not to enable status-bar'';
  };

  config = {
    systemd.user.services.status-bar = {
      environment.DISPLAY = ":0";
      path = [
        pkgs.networkmanager
        pkgs.bash
        pkgs.alsa-utils
        pkgs.coreutils-full
        pkgs.gnugrep
      ];
      serviceConfig = {
        Type = "simple";
        Restart = "always";
        ExecStartPre = "${pkgs.bash}/bin/bash -c 'if ! ${pkgs.procps}/bin/pgrep -x \"dwm\" > /dev/null; then echo \"dwm not up, cant start status bar.\"; exit 1; fi'";
        ExecStart = "${status-bar}/bin/status_bar";
      };
    };
    
    environment.systemPackages = lib.mkIf cfg.enable [
      status-bar
    ];
  };
}
