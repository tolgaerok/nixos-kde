{ config, pkgs, lib, ... }:

# Nix-specific settings and garbage collection options - Mostly research from NixOS wiki

let name = "tolga";
in {
  nix = {
    settings = {
      allowed-users = [ "@wheel" ];
      auto-optimise-store = true;
      sandbox = true;
      trusted-users = [ "root" "${name}" ];
      warn-dirty = false;
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--max-freed 1G --delete-older-than 7d";
    };
  };
}
