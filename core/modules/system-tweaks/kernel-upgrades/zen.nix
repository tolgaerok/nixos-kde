{ config, lib, pkgs, ... }:
# ---------------------------------------------------------------------
# Switch to ZEN kernel (Standard )
#---------------------------------------------------------------------
{
  boot.kernelPackages = {

    # Boot - Kernel Packages
    # https://search.nixos.org/options?channel=unstable&show=boot.kernelPackages

    kernelPackages = pkgs.linuxKernel.packages.linux_zen;

  };
}
