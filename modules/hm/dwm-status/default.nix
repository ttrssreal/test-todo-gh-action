{
  services.dwm-status = {
    enable = true;
    # "audio", "backlight", "battery", "cpu_load", "network", "time"
    order = [
      "network"
      "battery"
      "audio"
      "time"
    ];
  };
}
