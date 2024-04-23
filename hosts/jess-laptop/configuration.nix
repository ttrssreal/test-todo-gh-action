{ inputs, config, pkgs, ... }: {
  fonts = {
    packages = [
      pkgs.font-awesome
      pkgs.nerdfonts
    ];
    fontconfig = {
      enable = true;
      hinting.autohint = true;
    };
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
  };

  programs.zsh.enable = true;

  services.pcscd.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  users.users.jess = {
    isNormalUser = true;
    description = "Jess";
    shell = pkgs.zsh;
    home = "/home/jess";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = [
      pkgs.discord
      pkgs.nmap
      pkgs.man-pages
      pkgs.man-db
      pkgs.minikube
      pkgs.qpwgraph
      pkgs.neovim
      pkgs.tmux
      pkgs.sqlite
      pkgs.docker
      pkgs.thunderbird
      pkgs.cargo
      pkgs.st
      pkgs.firefox
      pkgs.flameshot
      pkgs.font-awesome
      pkgs.feh
      pkgs.ffmpeg
      pkgs.spotify
      pkgs.dmenu
      pkgs.obsidian
      pkgs.gnupg
      pkgs.pinentry
      pkgs.pinentry-curses
      pkgs.vscode
      pkgs.cntr
      pkgs.alsa-utils
      pkgs.gdb
      pkgs.pwndbg
      pkgs.picom
      pkgs.patchelf
      pkgs.file
      pkgs.whois
      pkgs.dig
      pkgs.burpsuite
      pkgs.screen
      pkgs.openssh
      pkgs.socat
      pkgs.ltrace
      pkgs.nerdfonts
      pkgs.ripgrep
      pkgs.clang-tools_17
      pkgs.libclang
      pkgs.gnumake
      pkgs.openjdk17
      pkgs.openjdk21
      pkgs.steam
      pkgs.mpv
      pkgs.htop
      pkgs.kubectl
      pkgs.jq
    ];
  };
}
