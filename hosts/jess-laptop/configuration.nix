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
    pinentryPackage = pkgs.pinentry-curses;

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
    packages = with pkgs; [
      discord
      nmap
      man-pages
      man-db
      minikube
      qpwgraph
      neovim
      tmux
      sqlite
      docker
      thunderbird
      cargo
      st
      firefox
      flameshot
      font-awesome
      feh
      ffmpeg
      spotify
      dmenu
      obsidian
      gnupg
      pinentry
      pinentry-curses
      vscode
      cntr
      alsa-utils
      gdb
      pwndbg
      picom
      patchelf
      file
      whois
      dig
      burpsuite
      screen
      openssh
      socat
      ltrace
      nerdfonts
      ripgrep
      clang-tools_17
      libclang
      gnumake
      openjdk17
      openjdk21
      steam
      mpv
      htop
      kubectl
      jq
      bintools
      ghidra
    ];
  };
}
