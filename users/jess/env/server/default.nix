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
      # /gpg
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

  home.homeDirectory = "/home/jess";
}
