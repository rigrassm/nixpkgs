{ fetchFromGitHub, python2Packages, lib }:

with python2Packages;

buildPythonApplication rec {
  pname = "couchpotato";
  version = "3.0.1";
  disabled = isPy3k;

  src = fetchFromGitHub {
    owner = "CouchPotato";
    repo = "CouchPotatoServer";
    rev = "build/${version}";
    hash = "sha256-0k8MqLnqYjhHPE9/jncTFIj1T4F2aXU4mXdeEimDB7M=";
  };

  format = "other";

  postPatch = ''
    substituteInPlace CouchPotato.py --replace "dirname(os.path.abspath(__file__))" "os.path.join(dirname(os.path.abspath(__file__)), '../${python.sitePackages}')"
  '';

  installPhase = ''
    mkdir -p $out/bin/
    mkdir -p $out/${python.sitePackages}/

    cp -r libs/* $out/${python.sitePackages}/
    cp -r couchpotato $out/${python.sitePackages}/

    cp CouchPotato.py $out/bin/couchpotato
    chmod +x $out/bin/*
  '';

  postFixup = ''
    wrapProgram "$out/bin/couchpotato" --set PYTHONPATH "$PYTHONPATH:$out/${python.sitePackages}"
  '';

  meta = {
    description = "Automatic movie downloading via NZBs and torrents";
    license     = lib.licenses.gpl3;
    homepage    = "https://couchpota.to/";
    maintainers = with lib.maintainers; [ fadenb ];
  };
}
