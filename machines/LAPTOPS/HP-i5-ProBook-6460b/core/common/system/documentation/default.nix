{ config, pkgs, lib, ... }:

{

  # Disable or remove local documentations for faster rebuilding
  # Only install the docs I use

  documentation = {
    doc.enable = true;
    info.enable = true;
    nixos.enable = true;
    enable = true; # This enables the overall documentation
    man.enable = true; # This enables documentation for 'man'
  };

}

