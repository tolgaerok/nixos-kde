{ config, pkgs, lib, ... }:

let scriptPath = "/etc/nixos/scripts/test.sh";
in {
  imports = [

    ./hardware/hardware-configuration.nix
    ./hardware/hardware-acceleration.nix
    ./pkgs/system-packages.nix
    ./network/system-networking.nix
    ./nix/system-nix-settings.nix
    ./printer/system-scanner-printer-settings.nix

  ];

  # Bootloader and System Settings
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Provides a virtual file system for environment modules
  # Solution from NixOS forums to help shotwell to keep preference settings
  services.envfs.enable = true;

  # Dynamic device management. udev is responsible for device detection, device node creation, and managing device events.
  services.udev.enable = true;

  # Automatically detect and manage storage devices connected to your system
  # This includes handling device mounting and unmounting, as well as providing a consistent interface for accessing and managing disk-related operations.
  services.udisks2.enable = true;

  # Activate the automatic trimming process for SSDs on the NixOS system  <=== Manual over-ride is sudo sudo fstrim / -v
  services.fstrim.enable = true;

  # Kernel Configuration
  boot.kernel.sysctl = { "vm.swappiness" = 1; }; 

  # Time Zone and Locale
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

  # X11 and KDE Plasma
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.layout = "au";
  services.xserver.xkbVariant = "";

  # Audio
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
  };

  # User Configuration
  users.users.tolga = {
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
    packages = with pkgs; [ ];
  };

  # Provide a graphical Bluetooth manager for desktop environments
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Nvidia drivers - NixOS wiki and help from David Turcotte (https://davidturcotte.com)
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.nvidia.modesetting.enable = true;

  # Enable the copying of system configuration files to the Nix store
  # Automatic system upgrades, automatically reboot after an upgrade if necessary
  system.copySystemConfiguration = true;
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  system.stateVersion = "23.05";

  systemd.extraConfig = "DefaultTimeoutStopSec=10s";
}
