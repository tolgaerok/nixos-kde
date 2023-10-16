{ config, pkgs, lib, ... }:

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
      allowed-users = [ "@wheel" ];
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      sandbox = true;
      trusted-users = [ "root" "${name}" ];

      # Avoid unwanted garbage collection when using nix-direnv
      keep-derivations = true;
      keep-outputs = true;
      warn-dirty = false;

    };

    # package = pkgs.nixUnstable; # Keep this if you want to use nixUnstable, otherwise replace with the appropriate nix version

    settings = {
      trusted-substituters = [

        "http://cache.nixos.org"
      ];

      substituters = [

        "http://cache.nixos.org"
      ];

    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

  };

}
