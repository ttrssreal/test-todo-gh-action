{
  fetchzip,
  stdenv,
  autoPatchelfHook,
  makeWrapper,
  fetchurl,
  unzip,
  libGL,
  glib,
  fontconfig,
  xorg,
  dbus,
  xkeyboard_config,
  libxkbcommon,
  wayland,
  qt6,
  xcb-util-cursor
}:
stdenv.mkDerivation rec {
  name = "binary-ninja";
  buildInputs = [
    autoPatchelfHook
    makeWrapper
    unzip
    libGL
    stdenv.cc.cc.lib
    glib
    fontconfig
    xorg.libXi
    xorg.libXrender
    xorg.libxcb.dev
    xorg.xcbutilwm         # libxcb-icccm.so.4
    xorg.xcbutilimage      # libxcb-image.so.0
    xorg.xcbutilkeysyms    # libxcb-keysyms.so.1
    xorg.xcbutilrenderutil # libxcb-render-util.so.0
    dbus
    libxkbcommon
    wayland
    qt6.full
  ];

  src = fetchzip {
    url = "https://binaryninja.s3.amazonaws.com/installers/binaryninja_personal_linux.zip";
    sha256 = "sha256-LIkSYxOhx/XRYEpdo32YLnVC4QlBeUha1k5DDrjSV48=";
  };

  buildPhase = ":";
  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/opt
    cp -r * $out/opt
    chmod +x $out/opt/binaryninja
    makeWrapper $out/opt/binaryninja \
          $out/bin/binaryninja \
          --prefix "QT_XKB_CONFIG_ROOT" ":" "${xkeyboard_config}/share/X11/xkb"
  '';
}

