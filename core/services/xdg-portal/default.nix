{ config, pkgs, lib, ... }:

{
  # ------------------------------------------
  # XDG Desktop Portal integration
  # ------------------------------------------

  environment.systemPackages = with pkgs; [
    libportal-qt5
    libsForQt5.bismuth
    libsForQt5.discover
    libsForQt5.kaccounts-integration
    libsForQt5.kaccounts-providers
    libsForQt5.kio-gdrive
    libsForQt5.packagekit-qt
    libsForQt5.qt5.qtgraphicaleffects
  ];

}
