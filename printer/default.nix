{ pkgs, ... }:

let
  extraBackends = [ pkgs.epkowa ];
  printerDrivers =
    [ pkgs.gutenprint pkgs.gutenprintBin pkgs.hplip pkgs.hplipWithPlugin ];
in {
  #---------------------------------------------------------------------
  # Scanner drivers
  #---------------------------------------------------------------------

  hardware.sane.enable = true;
  hardware.sane.extraBackends = extraBackends;

  #---------------------------------------------------------------------
  # Printers and printer drivers (To suit my HP LaserJet 600 M601)
  # In terminal: sudo NIXPKGS_ALLOW_UNFREE=1 nix-shell -p hplipWithPlugin 
  # then run: sudo -E hp-setup
  #---------------------------------------------------------------------

  services.avahi.enable = true;
  services.avahi.openFirewall = true;
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
