# will be real server soon

{ config
, lib
, hostname
, pkgs
, util
, ... }: {
  info.arch = "x86_64-linux";

  imports = lib.flatten [
    ./hardware-configuration.nix

    # shared
    (util.nixosModules [
      /startx
      /nixpkgs
      /nix
      # /podman
    ])
  ];

  hardware.graphics = {
    enable = true;
  };

  services = {
    xserver = {
      enable = true;
      xkb.layout = "nz";
      windowManager.dwm.enable = true;
      videoDrivers = ["nvidia"];
    };
    openssh.enable = true;
  };

  environment.systemPackages = [
    pkgs.dmenu
  ];

  # https://nixos.wiki/wiki/Nvidia
  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement = {
      enable = false;
      finegrained = false;
    };

    open = false;
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Bootloader.
  boot.loader.grub = {
    enable = true;
    device = "/dev/sdb";
    useOSProber = true;
  };

  networking = {
    hostName = hostname;
    firewall.enable = false;
    networkmanager.enable = true;
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
