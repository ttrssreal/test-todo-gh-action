{
  pkgs ?
    with builtins;
    let
      lockFileJSON = fromJSON (readFile ./flake.lock);
      nixpkgsNodeName = lockFileJSON.nodes.root.inputs.nixpkgs;
      nixpkgsLocked = lockFileJSON.nodes.${nixpkgsNodeName}.locked;
      nixpkgs = fetchTree nixpkgsLocked;
    in
      import nixpkgs {},
  inputs,
  ...
}:
pkgs.mkShell {
  name = "nix-config-dev-shell";
  nativeBuildInputs = with pkgs; [
    git
    nix

    # secrets manager
    inputs.agenix.packages.${system}.default
    rage

    inputs.home-manager.packages.${system}.default
  ];

  NIX_CONFIG = "extra-experimental-features = nix-command flakes repl-flake";

  # agenix: RULES environment variable with path to Nix file specifying recipient public keys.
  RULES = "./secrets.nix";
}
