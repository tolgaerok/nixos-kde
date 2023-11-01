{ config, lib, ... }:
with lib;

let

  name = "tolga";

in {

  imports = [

    ./dconf
    ./nixpkgs-config

  ];

  #---------------------------------------------------------------------  
  # Nix-specific settings and garbage collection options - 
  # Mostly research from NixOS wiki
  #---------------------------------------------------------------------  

  nix = {
    settings = {
      allowed-users = [

        "@wheel"
        "${name}"
      ];

      auto-optimise-store = true;

      experimental-features = [

        "flakes"
        "nix-command"
        "repl-flake"

      ];

      sandbox = "relaxed"; # if set to true, This enforces strict sandboxing, which is the default and most secure mode for building and running Nix packages

      trusted-users = [

        "${name}"
        "@wheel"
        "root"

      ];

      # Avoid unwanted garbage collection when using nix-direnv
      keep-derivations = true;
      keep-outputs = true;
      warn-dirty = false;
      tarball-ttl = 300;

      trusted-substituters = [

        "http://cache.nixos.org"
      ];

      substituters = [

        "http://cache.nixos.org"
      ];

    };

    extraOptions = "experimental-features = nix-command flakes";

    # package = pkgs.nixUnstable; # Keep this if you want to use nixUnstable, otherwise replace with the appropriate nix version

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
    };

  };

}
