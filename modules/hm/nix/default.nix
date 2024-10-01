{
  nix = {
    # user profile gc config
    gc = {
      automatic = true;
      # bi-monthly
      frequency = "*-*-1,15";
    };
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
}
