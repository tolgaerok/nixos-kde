{ config, pkgs, lib, ... }:

{
  # Services and module configurations
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # ... Other configurations ...
}
