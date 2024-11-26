{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    xgpro
    vscode
    discord
    firefox
    flameshot
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
