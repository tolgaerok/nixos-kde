# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [

    # ./hardware/gpu/intel/intel-laptop/HD4000/default.nix
    ../../core
    ../../core/core/gpu/amd/opengl                                    # AMD opengl
    ../../core/system-tweaks/kernel-tweaks/8GB-SYSTEM/8GB-SYSTEM.nix  # Kernel tweak for 8GB
    ../../core/system-tweaks/kernel-upgrades/xanmod.nix               # Xanmod kernel
    ../../core/system-tweaks/storage-tweaks/SSD/SSD-tweak.nix         # SSD read & write tweaks
    ../../core/system-tweaks/zram/zram-8GB-SYSTEM.nix                 # Zram tweak for 8GB
    ../../user/SOS/SOS.nix
    ../../user/tolga/tolga.nix
    ./Samsung-NP530U4B-hardware-configuration.nix

  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.loader.grub.copyKernels = true;
  boot.supportedFilesystems = [ "exfat" "ntfs" ];
  boot.tmp.cleanOnBoot = true;
  security.allowSimultaneousMultithreading = true;

  networking.hostName = "samsung_radeon"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

  };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "shaz";

  #---------------------------------------------------------------------
  # Allow unfree packages
  #---------------------------------------------------------------------

  environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs;
    [
      #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      #  wget
    ];

  #---------------------------------------------------------------------
  # Automatic system upgrades, automatically reboot after an upgrade if
  # necessary
  #---------------------------------------------------------------------

  # system.autoUpgrade.allowReboot = true;  # Very annoying .
  system.autoUpgrade.enable = true;
  system.copySystemConfiguration = true;
  system.stateVersion = "23.05";
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";

}
