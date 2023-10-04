{ config, pkgs, lib, ... }:

#---------------------------------------------------------------------
# Activate the automatic trimming process for SSDs on the NixOS system  
# Manual over-ride is sudo fstrim / -v
#---------------------------------------------------------------------

{

  services = { 
    fstrim = { 
      enable = true; 
    }; 
  };
}
