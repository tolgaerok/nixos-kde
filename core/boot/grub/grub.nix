{ config, lib, ... }:

{
  imports = [

    ../tmpfs/tmpfs.nix

  ];

  #---------------------------------------------------------------------
  # Bootloader for BIOS bootup
  #---------------------------------------------------------------------  
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Copies latest Linux kernels for smoother boot.
  boot.loader.grub.copyKernels = true;

  # Activates the Plymouth boot splash screen.
  boot.plymouth.enable = true;
  boot.plymouth.theme = "breeze";
}

