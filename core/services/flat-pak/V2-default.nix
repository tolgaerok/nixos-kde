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
  echo -e "\n\e[34mChecking flatpak repo: \e[32m¯\_👽_/¯\e[34m"

  # Enable Flatpak
  # -----------------------------------------------------------------------------------
  if ! flatpak remote-list | grep -q "flathub"; then
    if flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo; then
      echo -e "\e[34mFlatpak added and enabled: \e[32m[✔]\e[34m\n"
    else
      echo -e "\e[31mError: \e[33mFailed to enable Flatpak \e[31m[✘]\e[0m\n"
    fi
  else
    echo -e "\e[34mFlatpak passed: \e[32m[✔]\e[34m\n"
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