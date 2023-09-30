{ config, pkgs, ... }:

# ---------------------------------------------------------------------
# Enables support for Flatpak - Flatpak website
#---------------------------------------------------------------------

{
  services.flatpak.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
