{ pkgs, ... }:
# ---------------------------------------------------------------------
# Switch to most recent Xanmod kernel available
#---------------------------------------------------------------------
{

  #  boot.kernelPackages = pkgs.linuxPackages_xanmod; #(6.3)
  #  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest; #(6.4)
  boot.kernelPackages = pkgs.linuxPackages_xanmod_stable; # (6.4 hardened)
  #  boot.kernelPackages = pkgs.linuxPackages_xanmod_tt; #(6.5)

}
