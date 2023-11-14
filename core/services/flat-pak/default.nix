{ config, pkgs, lib, ... }:

# ---------------------------------------------------------------------
# Enables support for Flatpak - Flatpak website
#---------------------------------------------------------------------

{
  services.flatpak.enable = true;

  # For the sandboxed apps to work correctly, desktop integration portals need to be installed. 
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

}