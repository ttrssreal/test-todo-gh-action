{ lib
, fetchFromGitHub
, stdenv
}:
stdenv.mkDerivation {
  pname = "bt-con";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "ttrssreal";
    repo = "bt-con";
    rev = "22918a98dda86bdbc94d16ef7b38bca12d1a9922";
    hash = "sha256-Q6pEVv4JzPPCgi8Z2vq9EJCcYL953P7lCEOt4eCeURg=";
  };

  installPhase = ''
    mkdir -p $out/bin
    install -Dm755 bt-con.py $out/bin
    ln -s $out/bin/bt-con.py $out/bin/bt-con
  '';

  meta = with lib; {
    homepage = "https://github.com/ttrssreal/bt-con/";
    description = "select bluetooth devices to connect to.";
    platforms = platforms.unix;
  };
}
