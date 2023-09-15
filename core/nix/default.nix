{ config, pkgs, lib, ... }:

let

  name = "tolga";

in {

  imports = [

    # ./user-profile
    ./dconf
    ./nixpkgs-config
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
      sandbox = true;
      trusted-users = [ "root" "${name}" ];
      warn-dirty = false;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  # trim deleted blocks from ssd
  services.fstrim.enable = true;

  services.sshd.enable = true;

  # services.fwupd.enable = true;
}
