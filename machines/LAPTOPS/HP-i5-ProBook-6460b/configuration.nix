# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [

    # ./core/system-tweaks/kernel-upgrades/xanmod.nix
    # ./core/system-tweaks/zram/zram-8GB-SYSTEM.nix
    ./core/common
    ./core/system-tweaks/kernel-tweaks/8GB-SYSTEM/8GB-SYSTEM.nix
    ./core/system-tweaks/storage-tweaks/HHD/HHD-tweak.nix
    ./gpu/intel/HD-INTEL.nix
    ./hardware-configuration.nix
    ./user

  ];

  # -----------------------------------------------------------------
  #   Bootloader.
  # -----------------------------------------------------------------
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #   Register Appimages
  # -----------------------------------------------------------------
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = "\\xff\\xff\\xff\\xff\\x00\\x00\\x00\\x00\\xff\\xff\\xff";
    magicOrExtension = "\\x7fELF....AI\\x02";
  };

  networking.hostName = "HP-ProBook"; # Define your hostname.

  #---------------------------------------------------------------------
  #   Enable the OpenSSH daemon.
  #---------------------------------------------------------------------
  services.openssh.enable = true;

  # -----------------------------------------------------------------
  #   Enable networking
  # -----------------------------------------------------------------
  networking.networkmanager.enable = true;

  # -----------------------------------------------------------------
  #   Enable the X11 windowing system.
  # -----------------------------------------------------------------
  services.xserver.enable = true;

  # -----------------------------------------------------------------
  #   Enable the KDE Plasma Desktop Environment.
  # -----------------------------------------------------------------
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # -----------------------------------------------------------------
  #   Enable touchpad support (enabled default in most desktopManager).
  # -----------------------------------------------------------------
  services.xserver.libinput.enable = true;

  environment.systemPackages = with pkgs;
    [
      #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      #  wget
    ];

  #---------------------------------------------------------------------
  #   Automatic system upgrades, automatically reboot after an upgrade if
  #   necessary
  #---------------------------------------------------------------------
  # system.autoUpgrade.allowReboot = true;  # Very annoying .
  system.autoUpgrade.enable = true;
  system.copySystemConfiguration = true;
  system.stateVersion = "23.05";
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";

}
