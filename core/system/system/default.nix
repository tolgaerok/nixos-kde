{ config, pkgs, lib, ... }:
#---------------------------------------------------------------------
# Automatic system upgrades, automatically reboot after an upgrade if
# necessary
#---------------------------------------------------------------------

let

  version = "23.05";
  # version = "23.11";

in {
  system = {
    autoUpgrade = {
      enable = true;
      allowReboot = false;
    };

    copySystemConfiguration = true;
    stateVersion = "${version}";

  };
}
