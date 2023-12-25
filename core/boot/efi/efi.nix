{ config, pkgs, ... }:

{
  imports = [

    # Intialise tmpfs parameters
    ../tmpfs/tmpfs.nix

  ];
  
  #---------------------------------------------------------------------
  # Bootloader - EFI
  #---------------------------------------------------------------------
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;    # Enables the ability to modify EFI variables.
      systemd-boot.enable = true;         # Activates the systemd-boot bootloader.
    };

    initrd.systemd.enable = true;         # Enables systemd services in the initial ramdisk (initrd).    
    initrd.verbose = false;               # silent boot
    plymouth.enable = true;               # Activates the Plymouth boot splash screen.
    plymouth.theme = "breeze";            # Sets the Plymouth theme to "breeze."        
  };
}
