{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    xgpro
    vscode
    discord
    # TODO: manage profile in hm
    firefox
    flameshot
    # TODO: manange config through nix
    obsidian
    thunderbird
    spotify
    feh
    mpv
    prismlauncher
    openssh
    minikube
    qpwgraph
    font-awesome
    ffmpeg
    cntr
    alsa-utils
    pwndbg
    patchelf
    whois
    burpsuite
    socat
    nerdfonts
    ripgrep
    libclang
    htop
    kubectl
    jq
    ghidra
    obs-studio
    gimp
    p7zip
    inkscape
    jetbrains.idea-ultimate
  ];
}
