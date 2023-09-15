{ config, pkgs, ... }:

let

  copy-backup-nix = pkgs.writeScriptBin "copy-backup-nix" ''
    #!/bin/bash

    # Tolga Erok
        
    # Destination information
    DEST_DIR="/mnt/nixos_share/"
    SERVER_IP="192.168.0.11"
    MOUNT_OPTIONS="credentials=/etc/nixos/core/system/network/smb-secrets,uid=$USER,gid=samba,vers=3.1.1,cache=loose,file_mode=0777,dir_mode=0777"
    SOURCE_DIR="/etc/nixos/"

    start_time=$(date +%s)

    # Function to unmount smb share
    perform_unmount() {
        sudo umount -f /mnt/*
        sudo umount -l /mnt/*
    }

    # Unmount smb share
    perform_unmount

    # Mount smb share
    sudo mount -t cifs //$SERVER_IP/LINUXDATA2/ISO/COPY/ "$DEST_DIR" -o "$MOUNT_OPTIONS"

    # Check if mount was successful
    if [ $? -ne 0 ]; then
        echo "Mount failed. Exiting."
        exit 1
    fi

    # Prompt for confirmation before copying
    read -r -p "Are you sure you want to copy the contents of $SOURCE_DIR to $DEST_DIR? (y/n): " confirm
    if [[ $confirm != "y" ]]; then
        echo "Operation cancelled."
        perform_unmount
        exit 0
    fi

    # Prompt for confirmation to overwrite existing files globally
    read -r -p "Do you want to overwrite existing files? (y/n): " overwrite_confirm
    if [[ $overwrite_confirm == "y" ]]; then
        overwrite_option="-f"
    else
        overwrite_option="-n"
    fi

    # Copy the contents of /etc/nixos to destination using cp
    echo "Copying $SOURCE_DIR/ to $DEST_DIR/ ..."
    yes | cp -ir "$overwrite_option" "$SOURCE_DIR" "$DEST_DIR"  # Use 'yes' to automatically confirm all overwrite prompts

    # Display copied items and sizes
    copied_items=$(find "$SOURCE_DIR" -type f | wc -l)
    total_size=$(du -sh "$SOURCE_DIR" | cut -f1)
    echo "Copied Items: $copied_items, Total Size: $total_size"

    # Unmount smb share
    perform_unmount

    echo "Copy process completed." | ${pkgs.cowsay}/bin/cowsay | ${pkgs.lolcat}/bin/lolcat
    
    end_time=$(date +%s)
    time_taken=$((end_time - start_time))

    notify-send --icon=ktimetracker --app-name="Post set-up" "Basic set-up Complete" "Time taken: $time_taken seconds" -u normal

  '';

in {

  #---------------------------------------------------------------------
  # Type: copy-backup-nix in terminal to execute above bash script
  #---------------------------------------------------------------------

  environment.systemPackages = [ copy-backup-nix ];
}
