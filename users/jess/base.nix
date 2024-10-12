{ pkgs
, lib
, util
, ...
}: {
  imports = lib.lists.flatten [
    (util.hmModules [
      /nix
      /zsh
      /direnv
      /git
    ])
  ];

  home = {
    username = "jess";
    shellAliases = {
      vim = "nvim";
      gs = "git status";
      mrow = "echo mrow";
    };
    language.base = "en_NZ.UTF-8";
    packages = with pkgs; [
      gnumake bintools zip unzip
      man-pages man-db
      tmux screen
      ltrace
      gnupg
      file
      dig
    ];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";
}
