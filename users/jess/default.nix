{ inputs, config, pkgs, flakeDir, ... }: {
  imports = [
    (flakeDir + /modules/binaryninja.nix)
  ];

  users.users.jess = {
    isNormalUser = true;
    description = "Jess";
    shell = pkgs.zsh;
    home = "/home/jess";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = import ./pkgs.nix { inherit pkgs; };
  };

  programs.zsh.enable = true;
  environment.sessionVariables.EDITOR = "nvim";
  programs.steam.enable = true;

  nixpkgs.config.allowUnfree = true;

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

}

