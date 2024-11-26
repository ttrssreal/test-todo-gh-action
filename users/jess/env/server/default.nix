{ util
, lib
, userRoot
, ...
}: {
  imports = lib.flatten [
    (userRoot + /base.nix)
    ../jess-laptop/pkgs.nix

    (util.pathsFrom userRoot [
      # /dwm-status
      /alacritty
      # /direnv
      /gpg
      /nix
      /zsh
      /jessvim
    ])

    (util.hmModules [
      # /bt-con
      /picom
      # /secrets
    ])
  ];

  jess.git.forceGithubSSH = false;
  programs.alacritty.settings.font.size = lib.mkForce 11;

  home.homeDirectory = "/home/jess";
}
