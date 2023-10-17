{ config, pkgs, lib, ... }:

#---------------------------------------------------------------------
# Provides a virtual file system for environment modules. Solution
# from NixOS forums to help shotwell to keep preference settings
#---------------------------------------------------------------------

# services.envfs.enable = true;

{
  services = {
    envfs = {
      enable = true;
    };
  };
}
