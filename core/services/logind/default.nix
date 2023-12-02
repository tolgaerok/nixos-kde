{ config,  pkgs, lib,  ... }:

#  new service for tmpfs

 {
  services = {
    logind = {
      extraConfig = ''
        RuntimeDirectorySize=5G
        RuntimeDirectoryInodesMax=1048576
      '';
    };
  };
}
