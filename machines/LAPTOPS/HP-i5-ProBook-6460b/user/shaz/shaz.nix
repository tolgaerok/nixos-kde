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
  users.users.shaz = {
    isNormalUser = true;
    description = "shaz mason";
    homeMode = "0777";
    uid = 1002;
    shell = pkgs.bash;
    
    extraGroups = [
      "adbusers"
      "disk"
      "docker"
      "libvirtd"
      "networkmanager"
      "networkmanager"
      "samba"
      "smb"
      "udev"
      "wheel"
      "wheel"

    ];

    packages = with pkgs; [
      cowsay
      gum
      libnotify
      firefox
      kate
      espeak-classic
      glances
      fortune
      flatpak
      notify-desktop
      hw-probe
      inotify-tools
      ripgrep
      ripgrep-all

    ];

    #---------------------------------------------------------------------
    # Create new password => mkpasswd -m sha-512
    #---------------------------------------------------------------------
    hashedPassword =
      "$6$OyhETBwKnSHyAbWT$t6U8YlRFKYtt6Kqbt5jcvX/94RnFq5wVSBiGP2cVtgZLigwjNQyBqUDbyi2x31tcBygCKn3DmruCzLT6cAS/5.";

  };

}

