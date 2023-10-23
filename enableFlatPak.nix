{ config, pkgs, lib, ... }:

#---------------------------------------------------------------------
# Tolga Erok
# 22/10/23
# My personal flatpak automator for KDE Plasma
#
# ¯\_(ツ)_/¯
#---------------------------------------------------------------------

let

  enableFlatPak = ''
    # Check flatpak, add if not present 
    # ------------------------------------------------------------------
    echo -e "\n\e[34mChecking flatpak repo: \e[32m¯\_👽_/¯\e[34m"

    # Enable Flatpak
    # -----------------------------------------------------------------------------------
    if ! flatpak remote-list | grep -q "flathub"; then
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    else
      echo -e "\e[34mFlatpak enabled: \e[32m[✔]\e[34m\n"      
      sleep 1
    fi
  '';

in {

  config = {
    system.activationScripts.enableFlatPak = enableFlatPak;

  };

  services.flatpak.enable = true;

  # For the sandboxed apps to work correctly, desktop integration portals need to be installed. 
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
