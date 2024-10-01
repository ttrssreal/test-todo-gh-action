{
  description = "nix-config for my system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      # unstable branch
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-stable.url = "github:NixOS/nixpkgs?ref=nixos-24.05";
    status-bar.url = "github:ttrssreal/status-bar";
    nixvim.url = "github:nix-community/nixvim?ref=nixos-24.05";
    erosanix.url = "github:emmanuelrosa/erosanix";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = inputs @ { self, nixpkgs, ... }:
  let
    inherit (nixpkgs) lib;
    util = import ./util.nix { inherit util lib inputs; };
  in {
    devShells = util.mkDevShells nixpkgs [
      "x86_64-linux"
    ];

    nixosConfigurations =
      util.mkHost "jess-laptop" [
        "jess"
      ];
  };
}
