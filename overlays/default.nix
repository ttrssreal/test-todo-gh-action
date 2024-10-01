{ inputs
, util
, ...
}: let
  overlays = [
    ./expose-stable.nix
  ];
  realizeOverlay = overlay:
    import overlay { inherit inputs util; };
in builtins.map
  realizeOverlay
  overlays
