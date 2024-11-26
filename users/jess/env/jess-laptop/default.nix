{ util
, lib
, userRoot
, config
, ...
}: {
  imports = lib.flatten [
    (userRoot + /base.nix)
    ./pkgs.nix
    ./xinit.nix

    (util.pathsFrom userRoot [
      /dwm-status
      /alacritty
      /direnv
      /gpg
      /nix
      /zsh
      /jessvim
    ])

    (util.hmModules [
      /bt-con
      /picom
      /secrets
    ])
  ];

  secrets.shared = {
    b2-acc-id = {};
    b2-key = {};
  };

  systemd.user.startServices = "sd-switch";

  programs.rclone = {
    enable = true;
    remotes = {
      b2 = {
        config = {
          type = "b2";
          hard_delete = true;
        };
        secrets = {
          account = config.age.secrets.b2-acc-id.path;
          key = config.age.secrets.b2-key.path;
        };
      };

      ari.config = {
        type = "sftp";
        host = "ari";
        user = "jess";
        key_file = config.secrets.keyPath;
      };
    };
  };

  jess.bt-con.deviceAddrs = {
    "headphones" = "AC:80:0A:73:8A:3E";
  };

  home.homeDirectory = "/home/jess";

  secrets = {
    keyPath = "${config.home.homeDirectory}/.ssh/id_ed25519";
    pubKeyFile = userRoot + /id_ed25519.pub;
  };
}
