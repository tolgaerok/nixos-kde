{ config, pkgs, lib, ... }:

let

  create-smb-user = pkgs.writeScriptBin "create-smb-user" ''
    #!/usr/bin/env bash

    # Tolga Erok
    # 14/7/2023
    # Post SMB and shared folder setup!
    # ¯\_(ツ)_/¯

    RED='\e[1;31m'
    GREEN='\e[1;32m'
    YELLOW='\e[1;33m'
    BLUE='\e[1;34m'
    CYAN='\e[1;36m'
    WHITE='\e[1;37m'
    ORANGE='\e[1;93m'
    NC='\e[0m'

    clear

    echo -e "\\033[34;1mCreate SMB user and SMB group\\033[0m"
    echo -e "\\033[34;1mBy \\033[33mTolga Erok\\033[0m"

    # -----------------------------------------------------------------------------------
    #  Create some SMB user and group
    # -----------------------------------------------------------------------------------

    # Function to read user input and prompt for input
    prompt_input() {
        read -p "$1" value
        echo "$value"
    }

    # Create user/group

    # Prompt for the desired username and group for Samba
    sambausername=$(prompt_input $'\nEnter the USERNAME to add to Samba: ')
    sambagroup=$(prompt_input $'\nEnter the GROUP name to add username to Samba: ')

    echo ""

    # Create Samba user and group
    sudo groupadd "$sambagroup"
    sudo useradd -m "$sambausername"
    sudo smbpasswd -a "$sambausername"
    sudo usermod -aG "$sambagroup" "$sambausername"

    sleep 1

    # Location of private Samba folder
    shared_folder="/home/NixOs"
    echo ""

    # Create and configure the shared folder
    echo -e "\\033[34;1m ¯\_(ツ)_/¯ \\033[0m Setting up private Samba folder \n"

    sudo mkdir -p "$shared_folder"
    sudo chgrp "$sambagroup" "$shared_folder"
    sudo chmod 0757 "$shared_folder"
    sudo chown -R "$sambausername":"$sambagroup" "$shared_folder"

    # Pause and continue
    echo -e "\nContinuing..."
    read -r -n 1 -s -t 1
    sleep 1
  '';
in {

  #---------------------------------------------------------------------
  # Type: create-smb-user in terminal to execute above bash script
  #---------------------------------------------------------------------

  environment.systemPackages = [ create-smb-user ];
}
