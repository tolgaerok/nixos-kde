{ username, config, pkgs, stdenv, lib, ... }:

#---------------------------------------------------------------------
# Tolga Erok
# 10/6/2023
# My personal NIXOS KDE configuration 
# 
# ¯\_(ツ)_/¯
#---------------------------------------------------------------------

{

  imports = [

    # ../../core/system-tweaks/kernel-upgrades/latest-standard.nix          # Latest default NixOS kernel
    # ../../core/system-tweaks/kernel-upgrades/zen.nix                      # Zen kernel
    ../../core
    ../../core/gpu/nvidia/nvidia-stable-opengl                              # NVIDIA with hardware acceleration (Open-GL) for GT-1030++
    ../../core/system-tweaks/kernel-tweaks/28GB-SYSTEM/28GB-SYSTEM.nix      # Kernel tweak for 28GB
    ../../core/system-tweaks/kernel-upgrades/xanmod.nix                     # Xanmod kernel
    ../../core/system-tweaks/storage-tweaks/SSD/SSD-tweak.nix               # SSD read & write tweaks
    ../../core/system-tweaks/zram/zram-28GB-SYSTEM.nix                      # Zram tweak for 28GB
    ../../user/SOS/SOS.nix
    ../../user/tolga/tolga.nix
    ./EliteDesk-800-G1-hardware-configuration.nix
    
  ];

  #---------------------------------------------------------------------
  # Bootloader.
  #---------------------------------------------------------------------

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  #---------------------------------------------------------------------
  # Name of your pc to appear on the Network
  #---------------------------------------------------------------------

  networking.hostName = "HP-G800"; # Define your hostname.

  #---------------------------------------------------------------------
  # Prevent fragmentation and reassembly, which can improve network performance
  #---------------------------------------------------------------------

  networking.networkmanager.connectionConfig = {
    "ethernet.mtu" = 1462;
    "wifi.mtu" = 1462;
  };

  #---------------------------------------------------------------------
  # Install a couple of basic, off the bat pkgs
  #---------------------------------------------------------------------

  environment.systemPackages = with pkgs; [

    appimage-run
    espeak-classic
    firefox
    kate

    #-----------------------------------------------------------------  
    # Extra Audio packages
    #-----------------------------------------------------------------

    alsa-utils
    pavucontrol
    pulseaudio
    pulsemixer

  ];

  # --------------------------------------------------------------------
  # Permit Insecure Packages
  # --------------------------------------------------------------------

  nixpkgs.config.permittedInsecurePackages =
    [ "openssl-1.1.1u" "openssl-1.1.1v" "electron-12.2.3" ];

  #---------------------------------------------------------------------
  # Enable networking
  #---------------------------------------------------------------------

  networking.networkmanager.enable = true;

  #---------------------------------------------------------------------
  # Enhances file access capabilities for applications, including network 
  # file systems (SFTP, SMB, FTP), archive handling, and more.
  #---------------------------------------------------------------------

  # services.gvfs.enable = true;

  #---------------------------------------------------------------------
  # Enable the X11 windowing system.
  #---------------------------------------------------------------------

  services.xserver.enable = true;

  #---------------------------------------------------------------------
  # Enable the KDE Plasma Desktop Environment.
  #---------------------------------------------------------------------

  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  #---------------------------------------------------------------------
  # Enable CUPS to print documents.
  #---------------------------------------------------------------------

  services.printing.enable = true;

  # --------------------------------------------------------------------
  # Audio and extra audio packages
  #---------------------------------------------------------------------

  hardware.pulseaudio.enable = false;

  security.rtkit.enable = true;
  sound.enable = true;

  services.pipewire = {
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  #---------------------------------------------------------------------
  # Enable touchpad support (enabled default in most desktopManager).
  #---------------------------------------------------------------------

  services.xserver.libinput.enable = true;

  #---------------------------------------------------------------------
  # Allow unfree packages
  #---------------------------------------------------------------------

  environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";
  nixpkgs.config.allowUnfree = true;

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
