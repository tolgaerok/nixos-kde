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

{

  #---------------------------------------------------------------------
  # Import snippet files
  #---------------------------------------------------------------------

  imports = [ # ##  ONLY UNCOMMENT THE ./hardware GPU YOU WANT  ###

    # ./hardware/gpu/intel/intel-laptop/intel-acceleration.nix  # INTEL GPU with (Open-GL), tlp and auto-cpufreq     
    # ./hardware/gpu/nvidia/nvidia-stable/nvidia-stable.nix     # NVIDIA stable for GT-710--
    ./hardware-configuration.nix
    ./hardware/gpu/nvidia/nvidia-opengl/nvidia-opengl.nix # NVIDIA with hardware acceleration (Open-GL) for GT-1030++
    ./nix
    ./packages
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

  # --------------------------------------------------------------------
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
      "adbusers"
      "audio"
      "corectrl"
      "disk"
      "input"
      "lp"
      "mongodb"
      "mysql"
      "network"
      "network"
      "networkmanager"
      "postgres"
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
  # Automatic system upgrades, automatically reboot after an upgrade if 
  # necessary
  #---------------------------------------------------------------------

  # system.autoUpgrade.allowReboot = true;  # Very annoying .
  system.autoUpgrade.enable = true;
  system.copySystemConfiguration = true;
  system.stateVersion = "23.05";
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";

}
