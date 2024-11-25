{ pkgs
, ...
}: let
  zsh-nix-shell = rec {
    name = "zsh-nix-shell";
    file = "nix-shell.plugin.zsh";
    src = pkgs.fetchFromGitHub {
      owner = "chisui";
      repo = name;
      rev = "v0.8.0";
      sha256 = "sha256-Z6EYQdasvpl1P78poj9efnnLj7QQg13Me8x1Ryyw+dM=";
    };
  };
in {
  programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    history.ignoreSpace = true;
    plugins = [
      zsh-nix-shell
    ];
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "extract"
        "minikube"
      ];
    };

    initExtra = builtins.concatStringsSep "\n" 
      (map builtins.readFile [
        ./nix-direnv-utils.sh
        ./nix-clean.sh
      ]) +
        # https://github.com/nix-community/home-manager/issues/2751
        ''export EDITOR="nvim"''; # ??
  };
}
