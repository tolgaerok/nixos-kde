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

  # optimise.automatic = true;

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      sandbox = true;
      trusted-users = [ "root" "${name}" ];
      keep-outputs = true;
      keep-derivations = true;
      warn-dirty = false;
      allowed-users = [ "@wheel" ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
