{ config, pkgs, ... }:

{
  #---------------------------------------------------------------------
  # Bootloader - EFI
  #---------------------------------------------------------------------
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;    # Enables the ability to modify EFI variables.
      systemd-boot.enable = true;         # Activates the systemd-boot bootloader.
    };

    initrd.systemd.enable = true;         # Enables systemd services in the initial ramdisk (initrd).
    plymouth.enable = true;               # Activates the Plymouth boot splash screen.
    plymouth.theme = "breeze";            # Sets the Plymouth theme to "breeze."
    
    consoleLogLevel = 3;                  # Silence ACPI "errors" at boot shown before NixOS stage 1 output (default is 4).

    # tmpfs (a filesystem stored in RAM) settings for the NixOS boot process.    
    tmp.cleanOnBoot = true;               # Clean tmpfs on system boot, useful for ensuring a clean state.    
    tmp.useTmpfs = true;                  # Enable tmpfs for the specified directories.    
    tmp.tmpfsSize = "50%";                # Allocate 50% of RAM for tmpfs. You can adjust this percentage to your needs.
  };
}
