# MOTHERBOARD:	  Intel® Q87
# MODEL:        	HP EliteDesk 800 G1 SFF
# CPU:          	Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz x 8 (Haswell)
# GPU:          	NVIDIA GeForce GT 1030/PCIe/SSE2
# RAM:          	28 GB DDR3
# SATA:         	SAMSUNG SSD 870 EVO 500GB
# NETWORK:       	Intel Corporation Wi-Fi 6 AX210/AX211/AX411 160MHz 
# BLUE-TOOTH:   	REALTEK 5G
#---------------------------------------------------------------------

{ config, desktop, pkgs, lib, username, ... }:

let

in {

  #---------------------------------------------------------------------
  # Import snippet files:- 
  #---------------------------------------------------------------------

  imports = [

    ./custom-pkgs
    ./hardware-acceleration
    ./hardware-configuration
    ./nix
    ./pkgs    
    ./programs    
    ./services
    ./system

  ];

  #---------------------------------------------------------------------
  # Bootloader and System Settings
  #---------------------------------------------------------------------

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  #---------------------------------------------------------------------
  # SysRQ for is rebooting their machine properly if it freezes
  # SOURCE: https://oglo.dev/tutorials/sysrq/index.html
  #---------------------------------------------------------------------

  boot.kernel.sysctl."kernel.sysrq" = 1;

  #---------------------------------------------------------------------
  # Provides a virtual file system for environment modules. Solution
  # from NixOS forums to help shotwell to keep preference settings
  #---------------------------------------------------------------------

  services.envfs.enable = true;

  #---------------------------------------------------------------------
  # Dynamic device management. udev is responsible for device detection, 
  # device node creation, and managing device events.
  #---------------------------------------------------------------------

  services.udev.enable = true;

  #---------------------------------------------------------------------
  # Automatically detect and manage storage devices connected to your 
  # system. This includes handling device mounting and unmounting, 
  # as well as providing a consistent interface for accessing USB and 
  # managing disk-related operations.
  #---------------------------------------------------------------------

  services.devmon.enable = true;
  services.udisks2.enable = true;

  #---------------------------------------------------------------------
  # Kernel Configuration
  #---------------------------------------------------------------------

  boot.kernel.sysctl."vm.swappiness" = 1;

  #---------------------------------------------------------------------
  # Time Zone and Locale
  #---------------------------------------------------------------------

  time.timeZone = "Australia/Perth";
  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  #---------------------------------------------------------------------
  # X11 and KDE Plasma
  #---------------------------------------------------------------------

  services = {
    xserver = {
      desktopManager = { plasma5.enable = true; };
      videoDrivers = [ "nvidia" ];
      displayManager.sddm.enable = true;
      displayManager.sddm.autoNumlock = true;
      enable = true;
      layout = "au";
      xkbVariant = "";
    };
  };

  #---------------------------------------------------------------------
  # Audio
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
  # User Configuration
  #---------------------------------------------------------------------

  users.users.tolga = {
    homeMode = "0755";
    isNormalUser = true;
    description = "tolga erok";
    uid = 1000;
    extraGroups = [
      "audio"
      "disk"
      "input"
      "lp"
      "network"
      "networkmanager"
      "power"
      "scanner"
      "sound"
      "systemd-journal"
      "users"
      "video"
      "wheel"
    ];
    packages = [ pkgs.home-manager ];
  };

  #---------------------------------------------------------------------
  # Systemd tmpfiles configuration for user's home directory
  #---------------------------------------------------------------------

  systemd.user.tmpfiles.rules = [
    "d /home/tolga/Development/NixOS 0755 tolga users - -"
    # "d /home/tolga/Xcripts 0755 tolga users - -"
    # "d /home/tolga/Syncthing 0755 tolga users - -"

  ];

  #---------------------------------------------------------------------
  # Provide a graphical Bluetooth manager for desktop environments
  #---------------------------------------------------------------------

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  #---------------------------------------------------------------------
  # Nvidia drivers - NixOS wiki and help from David Turcotte. 
  # (https://davidturcotte.com)
  #---------------------------------------------------------------------

  hardware = {
    nvidia = {
      modesetting.enable = true;
      nvidiaPersistenced = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        vaapiVdpau
        libvdpau-va-gl
        vulkan-validation-layers
      ];
    };
  };

  # services.xserver.videoDrivers = [ "nvidia" ];

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
