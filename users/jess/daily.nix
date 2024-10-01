{ pkgs
, util
, lib
, osConfig
, ...
}: {
  imports = lib.lists.flatten [
    ./home/pkgs

    (util.hmModules [
      /alacritty
      /direnv
      /gpg
      /vscode
      /nix
      /nixvim
      /zsh
    ])
  ];

  config = {
    assertions = [
      { assertion = osConfig.jess.hasDisplay;
        message = "Daily needs a display"; }
    ];

    home.packages = with pkgs; [
      discord
      firefox
      flameshot
      obsidian
      thunderbird
      spotify
      feh
      mpv
    ];
  };
}
