{ lib, stdenv, fetchurl, gmp }:

stdenv.mkDerivation rec {
  name = "isl-0.17.1";

  src = fetchurl {
    urls = [
      "mirror://sourceforge/libisl/${name}.tar.xz"
      "https://libisl.sourceforge.io/${name}.tar.xz"
    ];
    sha256 = "be152e5c816b477594f4c6194b5666d8129f3a27702756ae9ff60346a8731647";
  };

  buildInputs = [ gmp ];

  enableParallelBuilding = true;

  meta = {
    homepage = "https://www.kotnet.org/~skimo/isl/";
    license = lib.licenses.lgpl21;
    description = "A library for manipulating sets and relations of integer points bounded by linear constraints";
    platforms = lib.platforms.all;
  };
}
