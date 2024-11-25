{ pkgs
, ...
}: {
  config = {
    services.xserver = {
      enable = true;
      xkb.layout = "nz";
      windowManager.dwm.enable = true;
    };

    environment.systemPackages = [
      pkgs.dmenu
    ];
  };
}
