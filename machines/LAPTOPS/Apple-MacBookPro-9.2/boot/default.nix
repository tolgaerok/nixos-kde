{ config, pkgs, ... }:

{
  #---------------------------------------------------------------------
  # Bootloader.
  #---------------------------------------------------------------------
  # boot.loader.systemd-boot.consoleMode = "auto";
  boot = {
    loader = {

      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;

    };

    initrd.systemd.enable = true;
    plymouth.enable = true;
    plymouth.theme = "breeze";

  };

}
