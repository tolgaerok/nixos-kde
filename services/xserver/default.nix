{ config, pkgs, lib, ... }:

{
  #---------------------------------------------------------------------
  # X11 and KDE Plasma
  #---------------------------------------------------------------------
  services.xserver = {
    enable = true;
    layout = "au";
    xkbVariant = "";

    desktopManager = { plasma5.enable = true; };

    displayManager.sddm = {
      enable = true;
      autoNumlock = true;

    };

  };
}
