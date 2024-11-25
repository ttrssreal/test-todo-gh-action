{
  nix = {
    # system gc config
    gc = {
      automatic = true;
      # monthly
      dates = "*-*-1";
      randomizedDelaySec = "1hr";
    };
    settings = {
      auto-optimise-store = true;
      # FIXME:
      trusted-users = [ "jess" ];
    };
    optimise.automatic = true;
  };
}
