{ inputs
, util
, ...
}: final: prev: with inputs; {
  stable = import nixpkgs-stable {
    config = util.pkgsConfig;
    system = final.system;
  };
}
