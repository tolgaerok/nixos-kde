{ config, pkgs, ... }:

let

  backup-nix = pkgs.writeScriptBin "backup-nix" ''
        #!/bin/bash

        # Tolga Erok
        
        # Source and destination information
        DEST_DIR="/mnt/smb-rsync/"
        SERVER_IP="192.168.0.20"
        SOURCE_DIR="/etc/nixos"

        # Mount options
        MOUNT_OPTIONS="credentials=/etc/nixos/network/smb-secrets,uid=$USER,gid=samba,vers=3.1.1,cache=loose,file_mode=0777,dir_mode=0777"   

        # Function to perform rsync
        perform_rsync() {
            # Mount smb share
            sudo mount -t cifs //$SERVER_IP/ISO/ "$DEST_DIR" -o "$MOUNT_OPTIONS"

            # Rsync
            echo -e "\e[1;34mSyncing $SOURCE_DIR/ $DEST_DIR/ ..."
            rsync -avz --progress --partial --bwlimit=500M --no-compress --relative --hard-links --update --stats "$SOURCE_DIR/" "$DEST_DIR/"
            echo -e "Finished syncing $SOURCE_DIR/ $DEST_DIR/" | ${pkgs.cowsay}/bin/cowsay | ${pkgs.lolcat}/bin/lolcat
            sleep 1
            echo

            # Display last update details
            last_update=$(date "+%Y-%m-%d %H:%M:%S")
            data_size=$(du -sh "$DEST_DIR" | cut -f1)
            echo -e "Last Update: $last_update, Data Size: $data_size" | ${pkgs.cowsay}/bin/cowsay | ${pkgs.lolcat}/bin/lolcat
        }

        # Unmount smb share
        perform_unmount() {
            sudo umount -f /mnt/*
            sudo umount -l /mnt/*
        }

        perform_unmount

        # Set the distribution profile
        distro="NIXOS-23-05"

        perform_rsync 
        perform_unmount
       
  '';

in {

  #---------------------------------------------------------------------
  # Type: backup-nix in terminal to execute above bash script
  #---------------------------------------------------------------------

  environment.systemPackages = [ backup-nix ];
}
