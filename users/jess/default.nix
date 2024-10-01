# NixOS module - entrypoint for HM

{ inputs
, pkgs
, hostname
, util
, ...
}: {
  imports = with inputs; [
    home-manager.nixosModules.home-manager
  ];

  users.users.jess = {
    description = "Jess";
    isNormalUser = true;
    shell = pkgs.zsh;
    # we install zsh via hm
    ignoreShellProgramCheck = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
    ];
  };

  fonts = {
    packages = [
      pkgs.font-awesome
      pkgs.nerdfonts
    ];
    fontDir.enable = true;
    fontconfig = {
      enable = true;
      hinting.autohint = true;
    };
  };

  home-manager = {
    backupFileExtension = "orig";
    useGlobalPkgs = true;
    useUserPackages = true;
    users.jess =
      import (./. + "/hosts/${hostname}");
    extraSpecialArgs = {
      inherit inputs util;
    };
  };
}
