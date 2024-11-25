{
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    # emulate these guys
    pulse.enable = true;
    jack.enable = true;
  };

  # lets pipewire ask for realtime scheduling
  security.rtkit.enable = true;
}
