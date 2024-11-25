{ util
, lib
, userRoot
, ...
}: {
  imports = lib.flatten [
    (userRoot + /base.nix)

    (util.pathFrom userRoot /jessvim)
  ];

  jess.git.forceGithubSSH = false;

  home.homeDirectory = "/home/jess";
}
