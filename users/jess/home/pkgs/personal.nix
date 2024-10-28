{ pkgs
, inputs
, util
, ...
}: let
  binja = (pkgs.callPackage (util.root /pkgs/binaryninja.nix) {});
  status-bar = inputs.status-bar.packages.x86_64-linux.default;
  # Xgpro to use with T56
  xgpro = 
    (pkgs.callPackage (util.root /pkgs/xgpro.nix) {
      inherit (inputs.erosanix.lib.x86_64-linux) mkWindowsApp;
    });
in {
  home.packages = [
    # binja
    status-bar
    xgpro
  ];
}
