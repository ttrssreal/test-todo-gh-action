{
  description = "nix configs for my hosts :3";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs?ref=nixos-24.05";
    home-manager = {
      url = "github:ttrssreal/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim.url = "github:nix-community/nixvim";
    # TODO: retire this
    # Issue URL: https://github.com/ttrssreal/test-todo-gh-action/issues/10
    status-bar.url = "github:ttrssreal/status-bar";
    erosanix.url = "github:emmanuelrosa/erosanix";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    agenix.url = "github:ryantm/agenix";
  };

  outputs = inputs @ { self, nixpkgs, ... }:
    let
      inherit (nixpkgs) lib;

      util = import ./util.nix { inherit util lib inputs; };
      mkNixosUsers = hostname: def: lib.concatMapAttrs
        (util.mkUserAtHost hostname def)
        def.config.home-manager.users;

      jess = ./users/jess;

    in {
      devShells = util.mkDevShells nixpkgs [
        "x86_64-linux"
      ];

      nixosConfigurations = {
        jess-laptop = util.mkHost "jess-laptop" [
          jess
        ];

        ari = util.mkHost "ari" [
          jess
        ];

        server = util.mkHost "server" [
          jess
        ];
      };

      homeConfigurations =
        lib.concatMapAttrs mkNixosUsers self.nixosConfigurations;

      templates = import ./templates;
    };
}
