{ config, pkgs, lib, ... }:

#---------------------------------------------------------------------
# Systemd tmpfiles rules for system directories
# Add a systemd tmpfiles rule that creates a directory /var/spool/samba 
# with permissions 1777 and ownership set to root:root.
#---------------------------------------------------------------------

{

  config.environment.systemPackages = with pkgs; [ gparted ];

  systemd = {
    tmpfiles.rules = [
      "D! /tmp 1777 root root 0"
      "D! /var/tmp 1777 root root 0"

      # "d /home/tolga/Development/NixOSx 0755 tolga users - -"

      "d /var/spool/samba 1777 root root -"
      "r! /tmp/**/*"
    ];
  };

  #---------------------------------------------------------------------
  # Systemd tmpfiles rules for user's home directory
  #---------------------------------------------------------------------
  #systemd.user.tmpfiles.rules = lib.optionalString (username == "tolga") [
  #config.systemd.tmpfiles.rules = [

  # "d /home/tolga/Development/NixOSx 0755 tolga users - -"
  #  "L+ /home/${username}/Desktop/gparted.desktop - - - - ${pkgs.gparted}/share/applications/gparted.desktop"
  # "d /home/tolga/Xcripts 0755 tolga users - -"
  # "d /home/tolga/Syncthing 0755 tolga users - -"

  #];

}
