{ config, pkgs, options, lib, ... }:

#---------------------------------------------------------------------
# Tolga Erok
# 17/10/23
# My personal NIXOS KDE configuration 
# 
# ¯\_(ツ)_/¯
#---------------------------------------------------------------------

let
  #---------------------------------------------------------------------
  #   Auto HOST chooser based on device product name
  #   Terminal:   cat /sys/devices/virtual/dmi/id/product_name
  #---------------------------------------------------------------------
  importfile = ( if builtins.readFile "/sys/devices/virtual/dmi/id/product_name" == "HP EliteBook Folio 9470m\n" then
    ./machines/LAPTOPS/HP-i7-Eilte-Folio-9470M/HP-FOLIO-configuration.nix

    else if builtins.readFile "/sys/devices/virtual/dmi/id/product_name" == "HP EliteDesk 800 G1 SFF\n" then
      ./machines/DESKTOPS/HP-i7-4770-EliteDesk-G1-800-SFF/EliteDesk-800-G1-configuration.nix

    else if builtins.readFile "/sys/devices/virtual/dmi/id/product_name" == "HP EliteDesk 8200\n" then
      ./machines/DESKTOPS/HP-i7-2660-EilteDesk-8200-SFF/EliteDesk-8200-configuration.nix

    else if builtins.readFile "/sys/devices/virtual/dmi/id/product_name" == "HP ProBook\n" then
      machines/LAPTOPS/HP-i5-ProBook-6460b/configuration.nix

    else if builtins.readFile "/sys/devices/virtual/dmi/id/product_name" == "Sony Vaio\n" then
      machines/LAPTOPS/Sony-Vaio-i3-330M/configuration.nix

    else if builtins.readFile "/sys/devices/virtual/dmi/id/product_name" == "Latitude E6540\n" then
      machines/LAPTOPS/Dell-Latitude-E6540/Dell-E6540-configuration.nix
  
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



