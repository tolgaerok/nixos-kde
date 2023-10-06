{ config, pkgs, stdenv, lib, ... }:

#---------------------------------------------------------------------
# Tolga Erok
# 10/6/2023
# My personal NIXOS KDE user configuration 
# ¯\_(ツ)_/¯
#---------------------------------------------------------------------

{
  imports = [

    ../local/australia.nix
    ./SOS/SOS.nix
    ./tolga/tolga.nix
    ./user-profile-pic

  ];

}
