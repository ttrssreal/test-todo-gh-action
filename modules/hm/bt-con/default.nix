{ pkgs
, util
, ...
}:
let
  bt-con = pkgs.callPackage (util.root /pkgs/bt-con.nix) {};
in {
  home.packages = [ bt-con ];
  xdg.configFile."bt-con/map".text = ''
    # mappings for bt-con
    # icon/name -> mac addr
    \uf025		AC:80:0A:73:8A:3E
  '';
}
