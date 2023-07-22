{ config, lib, ... }:

#---------------------------------------------------------------------
# Enable mutable users for interactive password change
#---------------------------------------------------------------------

let mutableUsersConfig = { users.mutableUsers = true; };

in {
  imports = [ ../../configuration.nix ];

  #---------------------------------------------------------------------
  # Merge the mutableUsersConfig with the main configuration
  #---------------------------------------------------------------------

  config = lib.mkMerge config mutableUsersConfig;
}
