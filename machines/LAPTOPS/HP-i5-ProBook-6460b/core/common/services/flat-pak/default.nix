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
  # Enable flatpak
  #---------------------------------------------------------------------
  services.flatpak.enable = true;

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
}
