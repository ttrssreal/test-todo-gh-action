{
  nix = {
    # system gc config
    gc = {
      automatic = true;
      # monthly
      dates = "*-*-1";
      randomizedDelaySec = "1hr";
    };
    settings.auto-optimise-store = true;
    optimise.automatic = true;
  };
}
