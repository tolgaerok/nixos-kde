{ config, pkgs, stdenv, lib, ... }:

#---------------------------------------------------------------------
# Tolga Erok
# 10/6/2023
# My personal NIXOS KDE user configuration 
# ¯\_(ツ)_/¯
#---------------------------------------------------------------------

{
  imports = [

    ../../locale/america.nix

  ];

  #---------------------------------------------------------------------
  # User Configuration
  #---------------------------------------------------------------------
  users.users.brian = {
    isNormalUser = true;
    description = "Brian Francisco";
    homeMode = "0777";
    uid = 1003;

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
      "$6$Tu7yLQIHKegAKA8Z$heAAQqzb2WXyWJ2YHcIRBBDZgGmAN0ukjUyWRDQ23XcAzPW9zQb6Ai36htKq84FxgoLCIcIRl2J1XQNO6q1TW0";

    #   openssh.authorizedKeys.keys = [
    #     "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDrS+VQMWkyNZ70Ym/TZoozhPfLpj9Rx+IlswOK01ZVx kintolga@gmail.com"
    #   ];

  };

  #---------------------------------------------------------------------
  # Back up nixos folder every 59 min 
  #---------------------------------------------------------------------
  services.cron = {
    enable = true;
    systemCronJobs = [

      "*/59 * * * * nixos-archive >> /home/brian/test.log"

    ];
  };
}

