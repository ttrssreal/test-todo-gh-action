{
  description = "nix-config for my system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs?ref=nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim.url = "github:nix-community/nixvim";
    status-bar.url = "github:ttrssreal/status-bar";
    erosanix.url = "github:emmanuelrosa/erosanix";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = inputs @ { self, nixpkgs, ... }:
  let
    inherit (nixpkgs) lib;
    util = import ./util.nix { inherit util lib inputs; };
    jess-laptop = util.mkHost "jess-laptop" [
      "jess"
    ];
    ari = util.mkHost "ari" [
      "jess"
    ];
  in {
    devShells = util.mkDevShells nixpkgs [
      "x86_64-linux"
    ];

    nixosConfigurations = 
        builtins.foldl' lib.trivial.mergeAttrs {} [
          jess-laptop
          ari
        ];
  };
}
