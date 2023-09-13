{ config, pkgs, stdenv, lib, ... }:

{

  imports = [

    ../../core
    ../../core/gpu/nvidia/nvidia-stable-opengl # NVIDIA with hardware acceleration (Open-GL) for GT-1030++
    ./EliteDesk-800-G1-hardware-configuration.nix

  ];
  
  #nix.nixPath =
  #  [ "nixpkgs=https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz" ];
  # Set the Nixpkgs channel to 'nixos-unstable'.
  # Set the Nixpkgs channel to 'nixos-unstable'.
  # nixpkgs.config = {
  #   packageOverrides = pkgs: {
  #     unstable = import <nixos-unstable> {
  #      inherit pkgs;
  #      config = config.nixpkgs.config;
  #    };
  #  };
  #};

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "HP-G800"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  environment.systemPackages = with pkgs; [
    firefox
    kate
    # thunderbird
  ];
  # Including this
  nixpkgs.config.permittedInsecurePackages =
    [ "openssl-1.1.1u" "openssl-1.1.1v" ];
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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.SOS = {
    isNormalUser = true;
    description = "S.O.S. Acct";
    uid = 1001;
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

    # Create new password =>    mkpasswd -m sha-512
    # Password = sos
    hashedPassword =
      "$6$JqHo60zkbI93byZo$qfa5tmBHnHHgb8O2SIgzhv8L8BIbvIRoBVC.ALWJUgeQjqRqB/0Qf29jhUOT2Mky4UmdBS.i1Fbh38vn0C1w9.";

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOvVHo9LMvIwrgm1Go89hsQy4tMpE5dsftxdJuqdrf99 kingtolga@gmail.com"
    ];

  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  #---------------------------------------------------------------------
  # User Configuration
  #---------------------------------------------------------------------

  users.users.tolga = {
    homeMode = "0755";
    isNormalUser = true;
    description = "King_Tolga";
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

    # Create new password =>    mkpasswd -m sha-512
    hashedPassword =
      "$6$yn6swk2CdH.7MJu/$GtdPxLNz0kyNmDXZ7FsCNVKvgd16Lk3xxp5AGxzq/ojyM6uderrA5SSTYz4Y8cvu97BHi7mCg6pB8zfhlUjHd.";

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFXBReTu5R0gJCtCwDo5sEAVikF05n75AOXwLjiv8u5M kingtolga@gmail.com"
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

  system.copySystemConfiguration = true;
  system.stateVersion = "23.05";
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";
  system.autoUpgrade.enable = true;
  #---------------------------------------------------------------------
  # Switch to most recent kernel available
  #---------------------------------------------------------------------

  zramSwap.enable = true;

}
