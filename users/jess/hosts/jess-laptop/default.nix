{ util
, lib
, pkgs
, ...
}: let
  jessHome = util.root /users/jess;
in {
  imports = lib.lists.flatten [
    (util.pathsFrom jessHome [
      /home/pkgs
      /base.nix
    ])

    (util.hmModules [
      /bt-con
      /picom
      /dwm-status
      /alacritty
      /direnv
      /gpg
      /vscode
      /nix
      /nixvim
      /zsh
    ])
  ];

  home.packages = with pkgs; [
    discord
    firefox
    flameshot
    obsidian
    thunderbird
    spotify
    feh
    mpv
  ];

  home.homeDirectory = "/home/jess";
}
