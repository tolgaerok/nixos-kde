{ config, pkgs, lib, inputs, stdenv, ... }:

let

  name = "tolga";

in {

  imports = [

    ./dconf
    ./nixpkgs-config

  ];

  # Nix-specific settings and garbage collection options - Mostly research from NixOS wiki

  # optimise.automatic = true;

  #package = pkgs.nixUnstable;

  # Make builds run with low priority so my system stays responsive
  #daemonCPUSchedPolicy = "idle";
  #daemonIOSchedClass = "idle";

  nix = {
    settings = {
      # use binary cache, its not gentoo
      builders-use-substitutes = true;
      max-jobs = "auto";

      # continue building derivations if one fails
      keep-going = true;
      log-lines = 20;

      allowed-users = [ "@wheel" ];
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      keep-derivations = true;
      keep-outputs = true;
      sandbox = true;
      trusted-users = [ "root" "${name}" "@wheel" ];
      warn-dirty = false;

      # use binary cache, its not gentoo
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://nixpkgs-unfree.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
      ];
    };

    gc = {

      # Cleanup un-refrenced packages in the Nix store older than 30 days
      automatic = lib.mkDefault true;
      dates = lib.mkDefault "weekly";
      options = lib.mkDefault "--delete-older-than 30d";

    };

  };
  # trim deleted blocks from ssd
  services.fstrim.enable = lib.mkDefault true;

  services.sshd.enable = lib.mkDefault true;
  # services.fwupd.enable = lib.mkDefault true;

}
