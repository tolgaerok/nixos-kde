{ config, lib, pkgs, ... }:

let
  extraBackends = [ pkgs.epkowa ];

  #---------------------------------------------------------------------
  # Printers and printer drivers (To suit my HP LaserJet 600 M601)
  #---------------------------------------------------------------------
  printerDrivers = [

    pkgs.gutenprint               # Drivers for many different printers from many different vendors
    pkgs.gutenprintBin            # Additional, binary-only drivers for some printers
    pkgs.hplip                    # Drivers for HP printers
    pkgs.hplipWithPlugin          # Drivers for HP printers, with the proprietary plugin. Use in terminal  NIXPKGS_ALLOW_UNFREE=1 nix-shell -p hplipWithPlugin --run 'sudo -E hp-setup'
    # pkgs.brgenml1cupswrapper    # Generic drivers for more Brother printers
    # pkgs.brgenml1lpr            # Generic drivers for more Brother printers
    # pkgs.brlaser                # Drivers for some Brother printers

  ];

in {

  #---------------------------------------------------------------------
  # Scanner and printing drivers
  #---------------------------------------------------------------------

  hardware.sane.enable = true;
  hardware.sane.extraBackends = extraBackends;
  services.printing.drivers = printerDrivers;
  services.printing.enable = true;

  #---------------------------------------------------------------------
  # Add a systemd tmpfiles rule that creates a directory /var/spool/samba 
  # with permissions 1777 and ownership set to root:root. 
  #---------------------------------------------------------------------

  systemd = {
    tmpfiles.rules = [
      "D! /tmp 1777 root root 0"
      "d /var/spool/samba 1777 root root -"
      "r! /tmp/**/*"
    ];
  };

}
