{ config, lib, ... }:

{

  #--------------------------------------------------------------------- 
  # Check for firmware upgrades during nixos-rebuilds
  #--------------------------------------------------------------------- 
  services.fwupd.enable = true;

}
