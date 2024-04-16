{ pkgs, flakeDir, ... }:
let
  status-bar = pkgs.callPackage (flakeDir + /pkgs/status-bar.nix) {};
in {
  # FIXME: dumb
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

  environment.systemPackages = [
    status-bar
  ];
}
