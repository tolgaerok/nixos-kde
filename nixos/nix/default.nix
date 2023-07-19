{ config, pkgs, lib, ... }:

let

  name = "tolga";

in {

  imports = [
    # Configuration for bash and fish
    ./aliases/system-bash-aliases.nix
    ./aliases/system-fish-aliases.nix
    # ./samba/default.nix

  ];

  # Nix-specific settings and garbage collection options - Mostly research from NixOS wiki
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      sandbox = true;
      trusted-users = [ "root" "${name}" ];
      warn-dirty = false;
      allowed-users = [ "@wheel" ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--max-freed 1G --delete-older-than 7d";
    };
  };
}
