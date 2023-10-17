{ config, pkgs, options, lib, ... }:

#---------------------------------------------------------------------
# Tolga Erok
# 10/6/2023
# My personal NIXOS KDE configuration 
# 
# ¯\_(ツ)_/¯
#---------------------------------------------------------------------

let
  #---------------------------------------------------------------------
  # I want my main rig: HP-i7-4770 x 8 EliteDesk G1 800 SFF Nvidia GT-1030
  #---------------------------------------------------------------------
  importfile = ( if builtins.readFile "/sys/devices/virtual/dmi/id/product_name" == "HP EliteDesk 800 G1 SFF\n" then
    ./machines/HP-i7-4770-EliteDesk-G1-800-SFF/EliteDesk-800-G1-configuration.nix
  
  else

    # This has to be manually symlinked per host/machine
    /etc/nixos/manual.nix

  );
in
{
  imports = [ 
    
    importfile 
    
  ];
}
