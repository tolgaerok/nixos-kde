{ pkgs, ... }:

with pkgs;

stdenv.mkDerivation rec {
  name = "sambaScript";
  src = ./samba.sh;
  buildInputs = [ bash ];
  phases = [ "install" ];
  installPhase = ''
    chmod +x $src
  '';
  shellHook = ''
    $src
  '';
}
