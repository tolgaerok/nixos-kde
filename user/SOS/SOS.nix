{ config, pkgs, stdenv, lib, ... }:

{

  imports = [

    

  ];

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

  # Configure keymap in X11
  services.xserver = {
    layout = "au";
    xkbVariant = "";
  };

  #---------------------------------------------------------------------
  # User Configuration
  #---------------------------------------------------------------------

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
      "$6$e3D/IsOy5iY5AeBx$ton91TEBWHri2EgTVarHisoEAhQhN8voekYYjWiTBB/aQK775POZpGcJYP/XnHcX5F1HCvAF1C7TldHnTNEmc1";

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOvVHo9LMvIwrgm1Go89hsQy4tMpE5dsftxdJuqdrf99 kingtolga@gmail.com"
    ];

  };

  # Generate an SSH Key Pair:                 ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
  # Locate Your Public Key:                   usually ~/.ssh/id_rsa.pub
  # Create or Edit the authorized_keys File:  cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
  # To create a new authorized_keys file:     mkdir -p ~/.ssh
  #                                           cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys
  # Set Permissions:                          chmod 700 ~/.ssh
  #                                           chmod 600 ~/.ssh/authorized_keys
  # Copy the Public Key Entry:                ssh-rsa bla bla bla== your_email@example.com
  #                                           Replace your_email@example.com

}

