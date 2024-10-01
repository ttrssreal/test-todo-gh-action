{pkgs,...}:
{
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 7;
        normal = {
          family = "FiraMono Nerd Font";
          style = "Medium";
        };
      };
      window.opacity = 0.85;
    };
  };
}
