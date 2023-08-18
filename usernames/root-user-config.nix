{ config, lib, ... }:

#---------------------------------------------------------------------
# Enable root user and set password
#---------------------------------------------------------------------

let
  rootUserConfig = {
    users.users.root = {
      isNormalUser = false;
      password = "123456789";
    };
  };
in {
  imports = [ ../../configuration.nix ];

  #---------------------------------------------------------------------
  # Merge the rootUserConfig with the main configuration
  #---------------------------------------------------------------------

  config = lib.mkMerge config rootUserConfig;
}
