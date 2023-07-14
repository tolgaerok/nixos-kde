{ pkgs, ... }:

let
  extraBackends = [ pkgs.epkowa ];
  printerDrivers = [ pkgs.gutenprint pkgs.hplip pkgs.hplipWithPlugin ];
in
{
  # Scanner drivers
  hardware.sane.enable = true;
  hardware.sane.extraBackends = extraBackends;

  # Printers and printer drivers (To suit my HP LaserJet 600 M601)
  # In terminal: sudo NIXPKGS_ALLOW_UNFREE=1 nix-shell -p hplipWithPlugin --run 'sudo -E hp-setup'
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.openFirewall = true;
  services.printing.drivers = printerDrivers;

  # Add a systemd tmpfiles rule that creates a directory /var/spool/samba with permissions 1777 and ownership set to root:root.
  systemd.tmpfiles.rules = [ "d /var/spool/samba 1777 root root -" ];

}
