{ config, pkgs, lib, ... }:

#---------------------------------------------------------------------
# Tolga Erok
# 25/10/23
# My personal flathub automator and buffer to stop KDE Plasma
# locking up and black-screen of death 
#
# ¯\_(ツ)_/¯
#---------------------------------------------------------------------

{

  imports = [

    #  ./tmpfs-mount.service
  ];

  services.flatpak.enable = true;

  # ---------------------------------------------------------------------
  # Add a systemd tmpfiles rule that creates a directory /var/spool/samba 
  # with permissions 1777 and ownership set to root:root. 
  # ---------------------------------------------------------------------
  systemd = {
    tmpfiles.rules = [
      "D! /tmp 1777 root root 0"
      "d /var/spool/samba 1777 root root -"
      "r! /tmp/**/*"
    ];

    extraConfig = "DefaultTimeoutStopSec=10s";

  };

  systemd.services = {
    # ---------------------------------------------------------------------
    # Do not restart these, since it messes up the current session
    # Idea's used from previous fedora woe's
    # ---------------------------------------------------------------------
    NetworkManager.restartIfChanged = false;
    display-manager.restartIfChanged = false;
    polkit.restartIfChanged = false;
    systemd-logind.restartIfChanged = false;
    wpa_supplicant.restartIfChanged = false;

    lock-before-sleeping = {
      restartIfChanged = false;
      unitConfig = {
        Description = "Helper service to bind locker to sleep.target";
      };

      serviceConfig = {
        ExecStart = "${pkgs.slock}/bin/slock";
        Type = "simple";
      };

      before = [ "pre-sleep.service" ];
      wantedBy = [ "pre-sleep.service" ];
      environment = {
        DISPLAY = ":0";
        XAUTHORITY = "/home/tolga/.Xauthority";
      };

    };

    # ---------------------------------------------------------------------
    # Configure the flathub remote
    # Terminal: sudo systemctl status configure-flathub-repo
    # ---------------------------------------------------------------------
    configure-flathub-repo = {
      enable = true;
      after = [ "multi-user.target" "network.target" ];
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

    customInfoScript = {
      description = "Custom Info Script";
      script = "/etc/nixos/core/system/systemd/custom-info-script.sh";
      wantedBy = [ "multi-user.target" ];
    };

    #--------------------------------------------------------------------- 
    # Modify autoconnect priority of the connection to tolgas home network
    #---------------------------------------------------------------------
    modify-autoconnect-priority = {
      description = "Modify autoconnect priority of OPTUS_B27161 connection";
      script = ''
        nmcli connection modify OPTUS_B27161 connection.autoconnect-priority 1
      '';
    };
    
    NetworkManager-wait-online.enable = false;

  };

}

