{ stdenv
, lib
, fetchFromGitHub
, rustPlatform
, font-awesome
}:
rustPlatform.buildRustPackage rec {
  pname = "status-bar";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "ttrssreal";
    repo = pname;
    rev = "refs/tags/v0.1";
    hash = "sha256-XDNCqfdgia2ExhQyZQpzSNJSu/QOh0+CRKWvMKcvr/c=";
  };

  cargoHash = "sha256-5xi9+AWPO8vDJB7NOve1Qe8+PJlquC9rDjyNt8yHZ3w=";

  buildInputs = [ font-awesome ];

  outputs = [ "out" ];

  meta = with lib; {
    description = "My dwm status bar.";
    homepage = "https://github.com/ttrssreal/StatusBar";
    mainProgram = "status_bar";
    platforms = platforms.unix;
  };
}
