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

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

}
