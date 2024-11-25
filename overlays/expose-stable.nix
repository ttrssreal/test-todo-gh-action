{ inputs
, util
, ...
}: util.mkOverlay (final: prev: {
  stable = import inputs.nixpkgs-stable {
    config = util.pkgsConfig;
    system = final.system;
  };
})
