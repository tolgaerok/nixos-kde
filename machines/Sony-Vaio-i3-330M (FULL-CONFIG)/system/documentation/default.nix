{ config, pkgs, lib, ... }:

{

  # Disable or remove local documentations for faster rebuilding
  # Only install the docs I use

  documentation = {

    doc.enable = true;
    enable = true; # This enables the overall documentation
    info.enable = true;
    man.enable = true; # This enables documentation for 'man'
    nixos.enable = true;
    
  };

}
