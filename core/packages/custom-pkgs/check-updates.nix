{ config, pkgs, ... }:

let

  nixos-check-updates = pkgs.writeScriptBin "nixos-check-updates" ''
    #!/bin/bash

    # Personal nixos update checker
    # Tolga Erok. ¯\_(ツ)_/¯
    # 14/11/2023

    start_time=$(date +%s)

    # Check for NixOS updates
    echo "Checking for NixOS updates..."
    # espeak -v en+m7 -s 165 "kust tom scripts! " --punct=","
    nix-channel --update

    # Check if there are updates available
    updates_available=$(nixos-rebuild dry-run --show-trace 2>&1 | grep "these derivations will be built" | wc -l)
     
    end_time=$(date +%s)
    time_taken=$((end_time - start_time))

    if [ "$updates_available" -gt 0 ]; then
      echo "Updates are available. Run 'sudo nixos-rebuild switch' to apply them."
      espeak -v en+m7 -s 165 "Updates! available! " --punct=","
      notify-send --icon=ktimetracker --app-name="Alert!" "UPDATES " "Updates available:

        (ツ)_/¯
    Time taken: $time_taken
    " -u normal

    else
      echo "No updates available."
      espeak -v en-swedish -s 165 "No! Updates! " --punct=","
      notify-send --icon=ktimetracker --app-name="Relax!" "Zero updates " "No updates available:

        (ツ)_/¯
    Time taken: $time_taken
    " -u normal
    fi

  '';

in {

  #---------------------------------------------------------------------
  # Type: check-updates in terminal to execute the above bash script
  #---------------------------------------------------------------------

  environment.systemPackages = [ nixos-check-updates ];
}
