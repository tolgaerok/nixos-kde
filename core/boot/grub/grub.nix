{ config, lib, ... }:

{
  # Bootloader for BIOS bootup
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Copies latest Linux kernels for smoother boot.
  boot.loader.grub.copyKernels = true;

  # Enable EFI installation as removable
  # boot.loader.grub.efiInstallAsRemovable = true;

  # silence ACPI "errors" at boot shown before NixOS stage 1 output (default is 4)
  boot.consoleLogLevel = 3;

  # tmpfs (a filesystem stored in RAM) settings for the NixOS boot process.
  # Clean tmpfs on system boot, useful for ensuring a clean state.
  boot.tmp.cleanOnBoot = true;

  # Enable tmpfs for the specified directories.
  boot.tmp.useTmpfs = true;

  # Allocate 50% of RAM for tmpfs. You can adjust this percentage to your needs.
  boot.tmp.tmpfsSize = "50%";
}

