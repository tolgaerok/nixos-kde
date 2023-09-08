# MOTHERBOARD:	  Intel® Q87
# MODEL:        	HP EliteDesk 800 G1 SFF
# CPU:          	Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz x 8 (Haswell)
# GPU:          	NVIDIA GeForce GT 1030/PCIe/SSE2
# RAM:          	28 GB DDR3
# SATA:         	SAMSUNG SSD 870 EVO 500GB
# NETWORK:       	Intel Corporation Wi-Fi 6 AX210/AX211/AX411 160MHz 
# BLUE-TOOTH:   	REALTEK 5G
#---------------------------------------------------------------------

{ config, desktop, pkgs, inputs, lib, username, ... }:

{

  #---------------------------------------------------------------------
  # Import snippet files
  #---------------------------------------------------------------------

  imports = [ # ##  ONLY UNCOMMENT THE ./hardware GPU YOU WANT  ###

    # ./core/gpu/intel/intel-laptop/                                        # INTEL GPU with (Open-GL), tlp and auto-cpufreq     
    # ./core/gpu/nvidia/nvidia-stable/nvidia-stable.nix                     # NVIDIA stable for GT-710--
    #./nix
    #./packages
    #./programs
    #./services
    #./system
    ./core
    ./core/gpu/nvidia/nvidia-stable-opengl                                  # NVIDIA with hardware acceleration (Open-GL) for GT-1030++
    ./hardware-configuration.nix

  ];

  # Including this
  # nixpkgs.config.permittedInsecurePackages = [ "openssl-1.1.1u" "openssl-1.1.1v" ];

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
      "docker"
      "input"
      "libvirtd"
      "lp"
      "mongodb"
      "mysql"
      "network"
      "networkmanager"
      "postgres"
      "power"
      "samba"
      "scanner"
      "smb"
      "sound"
      "systemd-journal"
      "udev"
      "users"
      "video"
      "wheel"

    ];

    packages = [ pkgs.home-manager ];

    # mkpasswd -m sha-512
    hashedPassword =
      "$6$yn6swk2CdH.7MJu/$GtdPxLNz0kyNmDXZ7FsCNVKvgd16Lk3xxp5AGxzq/ojyM6uderrA5SSTYz4Y8cvu97BHi7mCg6pB8zfhlUjHd.";

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOvVHo9LMvIwrgm1Go89hsQy4tMpE5dsftxdJuqdrf99 kingtolga@gmail.com"
    ];

    # Generate an SSH Key Pair:                 ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
    # Locate Your Public Key:                   usually ~/.ssh/id_rsa.pub 
    # Create or Edit the authorized_keys File:  cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
    # To create a new authorized_keys file:     mkdir -p ~/.ssh
    #                                           cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys
    # Set Permissions:                          chmod 700 ~/.ssh
    #                                           chmod 600 ~/.ssh/authorized_keys
    # Copy the Public Key Entry:                ssh-rsa bla bla bla== your_email@example.com
    #                                           Replace your_email@example.com 

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

  #---------------------------------------------------------------------
  # Switch to most recent kernel available
  #---------------------------------------------------------------------

  # boot.kernelPackages = pkgs.linuxPackages_latest;

}
