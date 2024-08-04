{ pkgs
, inputs
, flakeDir
}: with pkgs; [
  # Xgpro to use with T56
  (pkgs.callPackage (flakeDir + /pkgs/xgpro.nix) {
    inherit (inputs.erosanix.lib.x86_64-linux) mkWindowsApp;
  })

  (pkgs.callPackage (flakeDir + /pkgs/binaryninja.nix) {})
]
