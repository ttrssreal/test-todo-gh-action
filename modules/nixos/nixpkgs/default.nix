{ util
, inputs
, ...
}: {
  imports = [
    (util.root /overlays)
  ];

  nixpkgs = {
    config = util.pkgsConfig;
  };
}
