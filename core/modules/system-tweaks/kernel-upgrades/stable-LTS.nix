{ config, lib, pkgs, ... }:

# --------------------------------------------------------------------
# Switch to LTS (Standard Nixos)
#---------------------------------------------------------------------
{
  boot.kernelPackages = pkgs.linuxPackages;
  # Lock a kernel version
  # boot.kernelPackages = pkgs.linuxPackages_5_15;
}
