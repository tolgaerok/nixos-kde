{ config, lib, pkgs, ... }:

#---------------------------------------------
# Purely test purposes to run scripts from rbs
# ---------------------------------------------

{
  systemd.services.customInfoScript = {
    description = "Custom Info Script";
    script = "/etc/nixos/custom-info-script.sh";
    wantedBy = [ "multi-user.target" ];
  };

  system.activationScripts = {
    customInfoScript = {
      text = ''
        /etc/nixos/activation-scripts/run-custom-info-script.sh
      '';
    };
  };

}
