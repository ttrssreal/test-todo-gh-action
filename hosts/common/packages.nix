{ pkgs
, ...
}: {
  environment.systemPackages = with pkgs; [
    git
    vim
    curl wget
    zip unzip
    python3
  ];
}
