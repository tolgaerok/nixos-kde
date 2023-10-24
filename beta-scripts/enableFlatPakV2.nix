{ config, pkgs, ... }:
#---------------------------------------------------------------------
# Tolga Erok
# 23/10/23
# My personal flatpak automator for KDE Plasma
#
# ¯\_(ツ)_/¯
#---------------------------------------------------------------------
{
  services.flatpak.enable = true;

  systemd.services.configure-flathub-repo = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      if ! flatpak remote-list | grep -q "flathub"; then
        if flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo; then
          echo -e "\e[34mFlatpak repo enabled: \e[32m[✔]\e[34m\n"
        else
          echo -e "\e[31mError: \e[33mFailed to enable \e[31mFlatpak \e[31m[✘]\e[0m\n"
        fi
      else
        echo -e "\e[34mFlatpak checked and enabled: \e[32m[✔]\e[34m\n"
      fi
    '';
  };
}
