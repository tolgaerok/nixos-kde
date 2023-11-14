{ config, desktop, pkgs, lib, username, ... }:

{
  #---------------------------------------------------------------------
  # Systemd tmpfiles rules for system directories
  #---------------------------------------------------------------------
  systemd = {
    tmpfiles.rules = [
      "D! /tmp 1777 root root 0"
      "r! /tmp/**/*"
      "D! /var/tmp 1777 root root 0"
      "d /var/spool/samba 1777 root root -"
    ];
  };

  #---------------------------------------------------------------------
  # Systemd tmpfiles rules for user's home directory
  #---------------------------------------------------------------------
  systemd.user.tmpfiles.rules = lib.optionalString (username == "tolga") [
    # "d /home/tolga/Development/NixOS 0755 tolga users - -"
    # "d /home/tolga/Xcripts 0755 tolga users - -"
    # "d /home/tolga/Syncthing 0755 tolga users - -"
  ];
}
