{ config, pkgs, stdenv, lib, ... }:

#---------------------------------------------------------------------
# Tolga Erok
# 10/6/2023
# My personal NIXOS KDE user configuration 
# ¯\_(ツ)_/¯
#---------------------------------------------------------------------

{
  imports = [


    ./SOS/SOS.nix       # uid = 1001;
    # ./brian/brian.nix   # uid = 1003;
    ./shaz/shaz.nix     # uid = 1002; 
    ./tolga/tolga.nix   # uid = 1000;
    ./user-profile-pic

  ];

}
