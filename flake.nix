{
  description = "nix-config for my system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-23.11";

    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable }:
  let
    system = "x86_64-linux";
    hostname = "jess-laptop";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default = import ./shell.nix { inherit pkgs; };
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs;
        flakeDir = ./.;
      };
      modules = [
        ./hosts/${hostname}
      ];
    };
  };
}
