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
    # sudo nix-env -u '*'
    sudo nix-env --upgrade 

    sudo nixos-rebuild switch --upgrade
    # sudo nixos-rebuild switch

    clear && echo -e "\e[1;32m[✔]\e[0m Optimizing system...\n"
    sudo nix-store --optimise

    clear && echo -e "\e[1;32m[✔]\e[0m Checking updates for installed flatpak programs...\n"
    sudo flatpak update -y
    sleep 1
    
    clear && echo -e "\e[1;32m[✔]\e[0m Removing Old Flatpak Cruft...\n"
    flatpak uninstall --unused
    flatpak uninstall --delete-data
    sudo rm -rfv /var/tmp/flatpak-cache-*
    sleep 1

    clear && echo -e "\e[1;32m[✔]\e[0m Restarting kernel tweaks...\n"
    sleep 2
    sudo sysctl --system
    sleep 3

    clear && echo -e "\e[1;32m[✔]\e[0m System update's and optimization completed:\e[0m\n"

    echo "Your nix info:"
    echo "#---------------------------------------------------------------" | ${pkgs.lolcat}/bin/lolcat
    nix-shell -p nix-info --run 'nix-info -m' 

    echo "Your list of generations:"
    echo "#---------------------------------------------------------------" | ${pkgs.lolcat}/bin/lolcat
    sudo nix-env -p /nix/var/nix/profiles/system --list-generations

    end_time=$(date +%s)
    time_taken=$((end_time - start_time))

    notify-send --icon=ktimetracker --app-name="NixOS update..." "System updated and optimized" "
    Time taken: $time_taken seconds" -u normal

    df

    exit 0

  '';

in {

  #---------------------------------------------------------------------
  # Type: nixos-update in terminal to execute above bash script
  #---------------------------------------------------------------------

  environment.systemPackages = [ nixos-update ];
}
