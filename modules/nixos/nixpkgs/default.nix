{ util
, inputs
, ...
}: {
  nixpkgs = {
    config = util.pkgsConfig;
    overlays = import (util.root /overlays) {
      inherit inputs util;
    };
  };
}
