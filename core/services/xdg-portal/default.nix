{ config, pkgs, lib, ... }:

{
  # ------------------------------------------
  # XDG Desktop Portal integration
  # ------------------------------------------

  xdg.portal = {
    # enable = true;
    # xdgOpenUsePortal = true;

    # lxqt = {
    #   enable = false;
    #   styles = with pkgs;
    #     with libsForQt5; [
    #       qtstyleplugin-kvantum
    #       breeze-qt5
    #       qtcurve
    #     ];
    # };

    # Turn Wayland off
     wlr = { enable = false; };

    extraPortals = with pkgs;
      [
        #  xdg-desktop-portal-gtk
        #  xdg-desktop-portal-wlr
        # xdg-desktop-portal-kde
      ];

  };

}
