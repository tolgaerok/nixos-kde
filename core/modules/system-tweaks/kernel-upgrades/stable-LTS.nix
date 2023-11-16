{ config, lib, pkgs, ... }:

# --------------------------------------------------------------------
# Switch to LTS (Standard Nixos)
#---------------------------------------------------------------------
{
  boot.kernelPackages = pkgs.linuxPackages;
}
