{ config, pkgs, lib, ... }:

let
  distrobox = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "distrobox";
    version = "1.2.12-dev";

    src = pkgs.fetchgit {
      url = "https://github.com/89luca89/${pname}";
      rev = "aa1fe3769a054c90ffb30be577296b65640f0bdb";
      hash = "sha256-CGeK8HtYZDnDXCh8frVb+MPcLz8UlRBi/1qUBwZ9jeQ=";
    };

    phases = [ "unpackPhase" "installPhase" ];
    unpackPhase = "";

    installPhase = ''
      find . \( -not -name "distrobox-init" -and -not -name "distrobox-export" \) -type f | while read -r x; do patchShebangs "$x"; done
      mkdir -p $out/bin
      ./install -p $_
    '';
  };
in {
  environment.systemPackages = [ pkgs.xorg.xhost distrobox ];
  virtualisation.podman.enable = true;
  virtualisation.podman.dockerCompat = true;
  #  environment.shellInit = ''
  #    [ -n "$DISPLAY" ] && xhost +si:localuser:$USER || true
  #  '';
  #
  
}
