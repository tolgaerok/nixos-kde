{ config, pkgs, lib, ... }:

let

  name = "tolga";

in {

  imports = [   
    
    # ./samba/default.nix

    # Configuration for bash and fish
    ./aliases/system-bash-aliases.nix
    ./aliases/system-fish-aliases.nix

    # System condiguration
    ./dconf

  ];

  # Nix-specific settings and garbage collection options - Mostly research from NixOS wiki

  # optimise.automatic = true;

  nix = {
    settings = {
      allowed-users = [ "@wheel" ];
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      keep-derivations = true;
      keep-outputs = true;
      # nixPath = [ "nixos-config=/home/tolga/nixos/configuration.nix" ];
      sandbox = true;
      trusted-users = [ "root" "${name}" ];
      warn-dirty = false;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
