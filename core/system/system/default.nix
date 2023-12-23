{ config, pkgs, lib, attrs, ... }:
#---------------------------------------------------------------------
# Automatic system upgrades
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

    #---------------------------------------------
    # Custom derivation
    #---------------------------------------------
    activationScripts = {
      customInfoScript = {
        text = ''
          /etc/nixos/activation-scripts/run-custom-info-script.sh
        '';
      };
    };

  };
}

