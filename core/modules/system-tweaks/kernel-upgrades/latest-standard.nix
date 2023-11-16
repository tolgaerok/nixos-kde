{ config, lib, pkgs, ... }:

# --------------------------------------------------------------------
# Switch to most recent kernel available (Standard Nixos)
#---------------------------------------------------------------------
{
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
