{ config, pkgs, lib, ... }:

let

  nixos-update = pkgs.writeScriptBin "nixos-update" ''
    #!/bin/bash

    # Personal nixos updater script.
    # Tolga Erok. ¯\_(ツ)_/¯
    # 2/9/23

    set -e

    clear

    start_time=$(date +%s)
    clear

    # Function to update system

    echo -e "\e[1;31m[✘]\e[0m\e[1;33m There will be a very LONG delay here, checking for updates...\e[0m\n"
    sudo nix-channel --update
    echo -e "\e[1;32m[✔]\e[0m Checking updates for system and installed programs...\n"
    nix-env -u '*'
    sudo nixos-rebuild switch

    clear && echo -e "\e[1;32m[✔]\e[0m Optimizing system...\n"
    sudo nix-store --optimise
    clear && echo -e "\e[1;32m[✔]\e[0m Checking updates for installed flatpak programs...\n"
    sudo flatpak update -y

    echo "Update process completed."

    end_time=$(date +%s)
    time_taken=$((end_time - start_time))

    notify-send --icon=ktimetracker --app-name="NixOS update..." "System updated and optimized" "
    Time taken: $time_taken seconds" -u normal

        exit 0
  '';

in {

  #---------------------------------------------------------------------
  # Type: update-nixos in terminal to execute above bash script
  #---------------------------------------------------------------------

  environment.systemPackages = [ nixos-update ];
}
