# LAPTOP:           HP EliteBook Folio 9470m
# CPU:              Intel Core i7-3678U x 4 (2.1 GHz )
# GRAPHICS:         Intel HD Graphics 4000 (32MB Video Memory)
# MEMORY:           8GB RAM (Upgradable to 16GB) (1600 MHz DDR3 SDRAM)
# STORAGE:          500GB SSD Drive, Samsung EVO 870
# DISPLAY:          14-inch display (1366x768 pixels)
# PORTS:            Smart Card Reader, Headphone/Mic, Ethernet, DisplayPort, VGA, 3 x USB 3.0 Ports, SD/MMC Memory Reader
# NETWORK:          Wi-Fi: 802.11a/b/g/n (Intel Centrino Advanced-N 6235)
# Bluetooth:        Bluetooth 4.0+HS
# CARD SLOTS:       SD/MMC memory reader
#--------------------------------------------------------------------------------------------------------------------------

{ config, pkgs, lib,... }: 

with lib;

{
  imports = [
    
    # Select your kernel
    #---------------------------------------------
    # ../../core/system-tweaks/kernel-upgrades/xanmod.nix                                     # Xanmod kernel
    # ../../core/system-tweaks/kernel-upgrades/zen.nix                                        # Zen kernel
    ../../../core/system-tweaks/kernel-upgrades/latest-standard.nix                           # Latest default NixOS kernel

    # Main core
    # ---------------------------------------------
    ../../../core
    ../../../core/boot/grub/efi.nix                                                           # Use EFI loader on this machine, not GRUB
    ../../../core/gpu/intel/intel-laptop/HP-Folio-9470M/Eilite-Folio-9470M-HD-Intel-4000.nix
    ./HP-FOLIO-hardware-configuration.nix
    # ./boot

    # Custom System tweaks
    # ---------------------------------------------
    ../../../core/system-tweaks/kernel-tweaks/8GB-SYSTEM/8GB-SYSTEM.nix                        # Kernel tweak for 8GB
    ../../../core/system-tweaks/storage-tweaks/SSD/SSD-tweak.nix                               # SSD read & write tweaks
    ../../../core/system-tweaks/zram/zram-8GB-SYSTEM.nix                                       # Zram tweak for 8GB

    # Users
    # ---------------------------------------------
    ../../../locale/australia.nix
    ../../../user/SOS/SOS.nix
    ../../../user/tolga/tolga.nix

  ];

  # --------------------------------------------------------------------
  # Permit Insecure Packages
  # --------------------------------------------------------------------
  nixpkgs.config.permittedInsecurePackages =
    [ "openssl-1.1.1u" "openssl-1.1.1v" "electron-12.2.3" ];

  #---------------------------------------------------------------------
  # Name of your pc to appear on the Network
  #---------------------------------------------------------------------
  networking.hostName = "Folio_Laptop"; # Define your hostname.

  #---------------------------------------------------------------------
  # Enable networking
  #---------------------------------------------------------------------
  networking.networkmanager.enable = true;

  networking.networkmanager.connectionConfig = {
    "ethernet.mtu" = 1462;
    "wifi.mtu" = 1462;
  };

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

  #---------------------------------------------------------------------
  # Enable sound with pipewire.
  #---------------------------------------------------------------------
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

  };

  #---------------------------------------------------------------------
  # Enable touchpad support (enabled default in most desktopManager).
  #---------------------------------------------------------------------
  services.xserver.libinput.enable = true;

  #---------------------------------------------------------------------
  # Enable automatic login for the user.
  #---------------------------------------------------------------------
  # services.xserver.displayManager.autoLogin.enable = true;
  # services.xserver.displayManager.autoLogin.user = "tolga";

  #---------------------------------------------------------------------
  # Allow unfree packages
  #---------------------------------------------------------------------
  environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";
  nixpkgs.config.allowUnfree = true;

  #---------------------------------------------------------------------
  # Enable the OpenSSH daemon.
  #---------------------------------------------------------------------
  services.openssh.enable = true;

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
