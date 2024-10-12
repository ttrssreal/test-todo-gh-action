{ util
, lib
, pkgs
, ...
}: let
  jessHome = util.root /users/jess;
in {
  imports = lib.lists.flatten [
    ./home/pkgs

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

    (util.pathsFrom jessHome [
      /base.nix
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
