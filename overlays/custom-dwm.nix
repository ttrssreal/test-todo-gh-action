{ util
, ...
}: util.mkOverlay (final: prev: {
  dwm = prev.dwm.overrideAttrs (oldAttrs: {
    src = prev.fetchFromGitHub {
      owner = "ttrssreal";
      repo = "dwm";
      rev = "44b583e4240569d97115bed21d0b7c1d0a1272ba";
      hash = "sha256-T3j2WuPYH80CM/O9Lz/hI1TrZKeJ+DL87jBTXxlOryk=";
    };

    nativeBuildInputs = [ prev.pkg-config ];
    buildInputs = oldAttrs.buildInputs ++ [ prev.dbus ];
  });
})
