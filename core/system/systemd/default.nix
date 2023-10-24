{ config, pkgs, lib, ... }:

#---------------------------------------------------------------------
# Tolga Erok
# 24/10/23
# My personal flathub automator for KDE Plasma
#
# ¯\_(ツ)_/¯
#---------------------------------------------------------------------

{

  # ---------------------------------------------------------------------
  # Configure the flathub remote
  # Terminal: sudo systemctl status configure-flathub-repo
  #---------------------------------------------------------------------
  systemd.services.configure-flathub-repo = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      if flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo; then
        echo "¯\_(ツ)_/¯  Flathub repo added and configured successfully ==>  [✔] "
      else
        echo "¯\_(ツ)_/¯  Error: Failed to configure Flathub repo ==>  [✘]"
        exit 1  # Exit with an error code to indicate failure
      fi
    '';
  };

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

  #  systemd = {
  #    services = {
  #      # Do not restart these, since it fucks up the current session
  #      NetworkManager.restartIfChanged = false;
  #      display-manager.restartIfChanged = false;
  #      polkit.restartIfChanged = false;
  #      systemd-logind.restartIfChanged = false;
  #      wpa_supplicant.restartIfChanged = false;#
  #
  #      lock-before-sleeping = {
  #
  #        restartIfChanged = false;

  #       unitConfig = {
  #          Description = "Helper service to bind locker to sleep.target";
  #        };

  #        serviceConfig = {
  #          ExecStart = "${pkgs.slock}/bin/slock";
  #          Type = "simple";
  #        };

  #        before = [ "pre-sleep.service" ];

  #        wantedBy = [ "pre-sleep.service" ];

  #        environment = {
  #          DISPLAY = ":0";
  #          XAUTHORITY = "/home/tolga/.Xauthority";
  #        };
  #      };
  #    };

  #  };

}
