{ config, pkgs, lib, ... }:

let

  create-smb-user = pkgs.writeScriptBin "create-smb-user" ''
    #!/usr/bin/env bash

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

    # Create Samba user and group
    sudo groupadd "$sambagroup"
    sudo useradd -m "$sambausername"
    sudo smbpasswd -a "$sambausername"
    sudo usermod -aG "$sambagroup" "$sambausername"

    # Pause and continue
    echo -e "\nContinuing..."
    read -r -n 1 -s -t 1
    sleep 2
  '';
in {

  #---------------------------------------------------------------------
  # Type: create-smb-user in terminal to execute above bash script
  #---------------------------------------------------------------------

  environment.systemPackages = [ create-smb-user ];
}
