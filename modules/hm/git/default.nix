{ lib
, config
, ...
}: let
  cfg = config.jess.git;
in {
  options = {
    jess.git.forceSSH = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = {
    programs.git = {
      enable = true;
      userEmail = "jess@jessie.cafe";
      userName = "Jess";
      signing = {
        key = "BA3350686C918606";
        signByDefault = true;
      };
      extraConfig = lib.mkIf cfg.forceSSH {
        url."ssh://git@github.com/".insteadOf = "https://github.com/";
      };
      ignores = [
        ".direnv"
        ".envrc"
        ".env"
        ".local"
      ];
    };
  };
}
