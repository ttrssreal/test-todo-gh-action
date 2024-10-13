{ util
, lib
, ...
}: let
  jessHome = util.root /users/jess;
in {
  imports = lib.lists.flatten [
    (util.pathsFrom jessHome [
      /base.nix
    ])

    (util.hmModules [
      /nixvim
    ])
  ];

  jess.git.forceSSH = false;

  home.homeDirectory = "/home/jess";
}
