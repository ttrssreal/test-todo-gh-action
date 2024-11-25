{ pkgs
, util
, ...
}: {
  imports = util.nixosModules [
    /info
  ];

  environment.systemPackages = with pkgs; [
    git
    vim
    curl wget
    zip unzip
    python3
  ];

  i18n.defaultLocale = "en_NZ.UTF-8";
  time.timeZone = "Pacific/Auckland";
}
