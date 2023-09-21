{ config, pkgs, ... }:

{
  #---------------------------------------------------------------------
  # Bootloader.
  #---------------------------------------------------------------------

  #boot.loader.systemd-boot.consoleMode = "auto";
  boot = {
    loader = {

      # grub.device = "nodev";
      # grub.efiSupport = true;
      # grub.enable = true;
      # grub.useOSProber = true;
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;

    };

    initrd.systemd.enable = true;
    kernelParams = [ "quiet" ];
    plymouth.enable = true;
    plymouth.theme = "breeze";

  };

  #---------------------------------------------------------------------
  # NTFS Support
  #---------------------------------------------------------------------

  boot.supportedFilesystems = [ "ntfs" ];

  #---------------------------------------------------------------------
  # Enable memory compression for faster processing and less SSD usage
  #---------------------------------------------------------------------

  zramSwap.enable = true;
  zramSwap.memoryMax = 4294967296;
  zramSwap.memoryPercent = 20;

}
