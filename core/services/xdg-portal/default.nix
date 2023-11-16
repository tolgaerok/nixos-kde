{ config, pkgs, lib, ... }:

{
  # ------------------------------------------
  # XDG Desktop Portal integration
  # ------------------------------------------

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;

    lxqt = {
      enable = false;
      styles = with pkgs;
        with libsForQt5; [
          qtstyleplugin-kvantum
          catppuccin-kvantum
          breeze-qt5
          qtcurve
        ];
    };

    # Turn Wayland off
    wlr = {
      enable = true;

    };

    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-kde
      xdg-desktop-portal-wlr
    ];

  };

}
