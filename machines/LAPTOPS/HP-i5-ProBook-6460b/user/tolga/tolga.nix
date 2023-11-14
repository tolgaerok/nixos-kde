{ config, pkgs, stdenv, lib, ... }:

#---------------------------------------------------------------------
# Tolga Erok
# 10/6/2023
# My personal NIXOS KDE user configuration 
# ¯\_(ツ)_/¯
#---------------------------------------------------------------------

{
  imports = [

    ../../locale/australia.nix

  ];

  #---------------------------------------------------------------------
  # User Configuration
  #---------------------------------------------------------------------
  users.users.tolga = {
    isNormalUser = true;
    description = "King_Tolga";
    homeMode = "0755";
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

    #---------------------------------------------------------------------
    # Create new password => mkpasswd -m sha-512
    #---------------------------------------------------------------------
    hashedPassword =
      "$6$wgzbg6pZEFLdCQSt$dMlwT7mjlP4P4tl06gyCpx9ufnxoMrVXHQhfoIEaQKQ/XOHnIlzL3py7Tocdd1GFe13O.prBfOm9MqBbfM6jO0";

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

