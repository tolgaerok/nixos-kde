{ config, lib, ... }:

{
  # Bootloader for BIOS bootup
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Copies latest Linux kernels for smoother boot.
  boot.loader.grub.copyKernels = true;

  # tmpfs (a filesystem stored in RAM) settings for the NixOS boot process.
  # Clean tmpfs on system boot, useful for ensuring a clean state.
  boot.tmp.cleanOnBoot = true;

  # Enable tmpfs for the specified directories.
  boot.tmp.useTmpfs = true;

  # Allocate 50% of RAM for tmpfs. You can adjust this percentage to your needs.
  boot.tmp.tmpfsSize = "50%";
}

