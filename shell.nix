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
  ...
}:
pkgs.mkShell {
  name = "nix-config-dev-shell";
  NIX_CONFIG = "extra-experimental-features = nix-command flakes repl-flake";
  nativeBuildInputs = with pkgs; [
    git
    nix
  ];
}
