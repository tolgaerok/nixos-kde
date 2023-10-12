{ config, lib, pkgs, ... }:

let
  extraBackends = [ pkgs.epkowa ];
  printerDrivers = [

    pkgs.gutenprint
    pkgs.gutenprintBin
    pkgs.hplip
    pkgs.hplipWithPlugin

    #---------------------------------------------------------------------
    # Printers and printer drivers (To suit my HP LaserJet 600 M601)
    # In terminal: sudo NIXPKGS_ALLOW_UNFREE=1 nix-shell -p hplipWithPlugin 
    # then run: sudo -E hp-setup
    #---------------------------------------------------------------------

  ];

in {

  #---------------------------------------------------------------------
  # Scanner, avahi and printing drivers
  #---------------------------------------------------------------------

  hardware.sane.enable = true;
  hardware.sane.extraBackends = extraBackends;

  services.avahi.enable = true;
  services.avahi.openFirewall = true;
  services.printing.drivers = printerDrivers;
  services.printing.enable = true;

}
