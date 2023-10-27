{ config, pkgs, stdenv, lib, ... }:

#---------------------------------------------------------------------
# Tolga Erok
# 10/6/2023
# My personal NIXOS KDE user configuration 
# ¯\_(ツ)_/¯
#---------------------------------------------------------------------

{
  imports = [

    
  ];

  #---------------------------------------------------------------------
  # Set your time zone.
  #---------------------------------------------------------------------
  time.timeZone = "Australia/Perth";

  #---------------------------------------------------------------------
  # Select internationalisation properties.
  #---------------------------------------------------------------------
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
  # Configure keymap in X11
  #---------------------------------------------------------------------
  services.xserver = {
    layout = "au";
    xkbVariant = "";
  };

  #---------------------------------------------------------------------
  # User Configuration
  #---------------------------------------------------------------------
  users.users.tolga = {
    homeMode = "0755";
    isNormalUser = true;
    home = "/home/tolga/";
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
      "storage"
      "systemd-journal"
      "udev"
      "users"
      "video"
      "wheel"
    ];

    packages = [ pkgs.home-manager ];

    #---------------------------------------------------------------------
    # Create new password => mkpasswd -m sha-512
    #---------------------------------------------------------------------
    hashedPassword =
      "$6$yn6swk2CdH.7MJu/$GtdPxLNz0kyNmDXZ7FsCNVKvgd16Lk3xxp5AGxzq/ojyM6uderrA5SSTYz4Y8cvu97BHi7mCg6pB8zfhlUjHd.";

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDrS+VQMWkyNZ70Ym/TZoozhPfLpj9Rx+IlswOK01ZVx kintolga@gmail.com"
    ];

  };

  #---------------------------------------------------------------------
  # Back up nixos folder every 59 min 
  #---------------------------------------------------------------------
  services.cron = {
    enable = true;
    systemCronJobs = [

      "*/59 * * * * nixos-archive >> /home/tolga/test.log"

    ];
  };
}

