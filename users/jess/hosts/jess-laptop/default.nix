{ util
, lib
, ...
}: let
  jessHome = util.root /users/jess;
in {
  imports = lib.lists.flatten [
    (util.hmModules [
      /bt-con
    ])

    (util.pathsFrom jessHome [
      /minimal.nix
      /daily.nix
    ])
  ];

  home.homeDirectory = "/home/jess";
}
