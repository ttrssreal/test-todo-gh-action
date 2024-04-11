{ inputs, config, pkgs, ... }:
let
  cfg = config.programs.alacritty;
  unstable-pkgs = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;
  lib = pkgs.lib;
in {
  options = {
    programs.alacritty = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = ''
          If enabled alacritty will be installed, the version
          depending on the value of option `unstable`.
          '';
      };
      unstable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = ''
          Whether or not to use the nixpkgs unstable/latest
          version of alacritty.
        '';
      };
    };
  };

  config = {
    environment.systemPackages = lib.mkIf cfg.enable (lib.mkMerge [
      (lib.mkIf (!cfg.unstable) [ pkgs.alacritty ])
      (lib.mkIf cfg.unstable [ unstable-pkgs.alacritty ])
    ]);
  };
}
