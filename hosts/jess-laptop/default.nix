# HW:
# Version: Yoga 7 14ITL5
# Cpu x 4: 11th Gen Intel(R) Core(TM) i7-1165G7 @ 2.80GHz
# Arch: x86_64-linux

{ inputs
, hostname
, pkgs
, util
, lib
, ...
}: {
  info.arch = "x86_64-linux";

  imports = with inputs; lib.flatten [
    ./hardware-configuration.nix
    nixos-hardware.nixosModules.lenovo-yoga-7-14ARH7-amdgpu

    ./dwm
    ./bluetooth
    ./pipewire

    # shared
    (util.nixosModules [
      /startx
      /nixpkgs
      /nix
      /podman
      /secrets
    ])
  ];

  secrets.pubKeyFile = ./ssh_host_key.pub;

  services.thermald.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
    ];
  };

  networking = {
    hostName = hostname;
    firewall.enable = false;
    networkmanager.enable = true;
  };

  programs = {
    # needs to be system level as the module configures firewalls
    # and some opengl settings
    steam.enable = true;
    # this is the backend database gsettings uses, lets keep gnome
    # apps happy
    dconf.enable = true;
  };

  boot = {
    loader.systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
    # this driver was being fucky with rfkill
    # https://github.com/torvalds/linux/blob/9852d85ec9/drivers/platform/x86/ideapad-laptop.c#L1930-L1944
    blacklistedKernelModules = [ "ideapad_laptop" ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
