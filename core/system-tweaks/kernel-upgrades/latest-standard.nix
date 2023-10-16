{ config, lib, pkgs, ... }:

# --------------------------------------------------------------------
# Switch to most recent kernel available (Standard Nixos)
#---------------------------------------------------------------------
{
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # linuxPackages_latest = pkgs.linuxPackages_latest; 

}
