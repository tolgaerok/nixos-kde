{ config, pkgs, lib, ... }:

# Configure the logind service with custom parameters
# This NixOS configuration snippet adjusts the settings for the logind service, specifically focusing on the runtime directories. The parameters set include:
# - `RuntimeDirectorySize=100%`: Allows runtime directories to use up to 100% of the available space, dynamically adjusting to the available disk space.
# - `RuntimeDirectoryInodesMax=1048576`: Sets the maximum number of inodes in runtime directories to 1,048,576, limiting the total number of files and directories that can be created.
# These configurations aim to manage resources effectively and prevent potential issues related to disk space exhaustion or an excessive number of files in user-specific runtime directories.

{
  services = {
    logind = {
      extraConfig = ''
        # Set the maximum size of runtime directories to 100%
        RuntimeDirectorySize=100%

        # Set the maximum number of inodes in runtime directories to 1048576
        RuntimeDirectoryInodesMax=1048576
      '';
    };
  };
}
