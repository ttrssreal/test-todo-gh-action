{ pkgs
, ...
}: {
  home.packages = with pkgs; [
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
    steam
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
