{ pkgs
, ...
}: {
  programs.nixvim.extraPlugins = [ (pkgs.vimUtils.buildVimPlugin rec {
    name = "nvim-godot";
    src = pkgs.fetchFromGitHub {
      owner = "niscolas";
      repo = name;
      rev = "bab4677b1bed9c2d90424dc810e2922e1aff119a";
      hash = "sha256-bL33/S+caNmEYGcMLNCanFZyEYUOUmSsedCVBn4tV3g=";
    };
  }) ];
}
