{ config, desktop, pkgs, lib, username, ... }:

{

  config.environment.systemPackages = with pkgs; [ gparted ];

  #---------------------------------------------------------------------
  # Systemd tmpfiles rules for system directories
  #---------------------------------------------------------------------
  systemd = {

    tmpfiles.rules = [

      "D! /tmp 1777 root root 0"
      "D! /var/tmp 1777 root root 0"

      # "d /home/tolga/Development/NixOSx 0755 tolga users - -"

      "d /var/spool/samba 1777 root root -"
      "r! /tmp/**/*"
<<<<<<< HEAD
      
=======

>>>>>>> 3217d15e0a99eabad70a7f1f735b24a0540c95e4
    ];

  };

  #---------------------------------------------------------------------
  # Systemd tmpfiles rules for user's home directory
  #---------------------------------------------------------------------
  #systemd.user.tmpfiles.rules = lib.optionalString (username == "tolga") [
  
<<<<<<< HEAD
  config.systemd.tmpfiles.rules = [
=======
config.systemd.tmpfiles.rules = [
>>>>>>> 3217d15e0a99eabad70a7f1f735b24a0540c95e4

    # "d /home/tolga/Development/NixOSx 0755 tolga users - -"
    # "L+ /home/${username}/Desktop/gparted.desktop - - - - ${pkgs.gparted}/share/applications/gparted.desktop"
    # "d /home/tolga/Xcripts 0755 tolga users - -"
    # "d /home/tolga/Syncthing 0755 tolga users - -"

  ];

}
