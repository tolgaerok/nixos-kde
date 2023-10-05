{ config, pkgs, lib, ... }:

{
  # ------------------------------------------
  # Kde Desktop integration
  # ------------------------------------------

  environment.systemPackages = with pkgs; [

    # ------------------------------------------
    # BAD CONFLICTS: NOT SURE WHY!
    # ------------------------------------------
    # libsForQt5.discover
    # libsForQt5.bismuth
    # libsForQt5.kio-gdrive
    # libportal-qt5
    # libsForQt5.kaccounts-integration
    # libsForQt5.kaccounts-providers
    # libsForQt5.packagekit-qt
    # libsForQt5.qt5.qtgraphicaleffects
    # libsForQt5.sddm-kcm

  ];

}
