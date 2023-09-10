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

{ config, pkgs, ... }:

{
  imports = [

    ./core
    ./core/gpu/intel/intel-laptop # INTEL GPU with (Open-GL), HP Eilite-Folio-9470M-HD-Intel-4000
    ./hardware-configuration.nix

  ];

  # Including this
  nixpkgs.config.permittedInsecurePackages =
    [ "openssl-1.1.1u" "openssl-1.1.1v" ];

  # Bootloader.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.consoleMode = "auto";
  boot.loader.systemd-boot.enable = true;

  # Latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Perth";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "au";
    xkbVariant = "";
  };

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

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tolga = {
    isNormalUser = true;
    description = "User's Full Name";

    homeMode = "0755"; # <-----  Copy from here
    uid = 1000; # Replace with your specific UID
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
    packages = [ pkgs.home-manager ]; # <-----  To here

  };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "tolga";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable automatic system upgrades and reboots if necessary
  # system.autoUpgrade.allowReboot = true;

  system.autoUpgrade.enable = true;
  system.copySystemConfiguration = true;
  system.stateVersion = "23.05"; # Did you read the comment?
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";

}
