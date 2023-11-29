{
  config,
  pkgs,
  lib,
  ...
}: {
  services = {
    logind = {
      extraConfig = ''
        RuntimeDirectorySize=5G
        RuntimeDirectoryInodesMax=1048576
      '';
    };
  };
}