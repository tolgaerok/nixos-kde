#!/bin/bash

# Function to print colored output

# Function to unmount smb share
perform_unmount() {
    sudo umount -f /mnt/*
    sudo umount -l /mnt/*
}

# Set your variables
DEST_DIR="/mnt/smb-rsync/"
MOUNT_OPTIONS="credentials=/etc/nixos/system/network/smb-secrets,uid=$USER,gid=samba,vers=3.1.1,cache=loose,file_mode=0777,dir_mode=0777"
USERNAME=$(id -u -n 1000)

# Function to perform rsync
perform_rsync() {
    local SOURCE_DIR="$1"
    local DEST_DIR="$2"

    # Prompt user for server IP
    read -p "Enter server IP: " SERVER_IP

    # Prompt user for destination structure
    read -p "Enter destination structure (e.g., LINUXDATA2/HOME/PROFILES/\"$distro\"/TOLGA/): " DESTINATION_STRUCTURE

    # Combine the destination structure with the server IP
    FULL_DEST_DIR="//${SERVER_IP}/${DESTINATION_STRUCTURE}"

    # Mount smb share
    sudo mount -t cifs "$FULL_DEST_DIR" "$DEST_DIR" -o "$MOUNT_OPTIONS"

    # Check if destination directory exists, create if not
    if [ ! -d "$DEST_DIR" ]; then
        read -p "Destination directory does not exist. Create it? (y/n): " create_dir
        if [ "$create_dir" == "y" ]; then
            sudo mkdir -p "$DEST_DIR"
        else
            echo "Exiting..."
            perform_unmount
            exit 0
        fi
    fi

    # rsync with --exclude option to skip hidden files/folders
    echo -e "\e[1;34mSyncing $SOURCE_DIR/ $FULL_DEST_DIR/ ...\e[0m"
    rsync -avz --no-links --progress --partial --partial-dir=.rsync-partial --bwlimit=500M --no-compress --relative --hard-links --exclude ".*" --update --stats "$SOURCE_DIR/" "$DEST_DIR/"
    echo -e "\e[1;31mFinished syncing $SOURCE_DIR/ $FULL_DEST_DIR/\e[0m"
    sleep 1
    echo

    echo -e "Press Enter to go back to the menu."
    read -r -s
    perform_unmount
    clear
}

# Main loop
while true; do
    clear
    echo -e "\n\e[1;31mRSYNC from /home/$USERNAME > Remote Server:\e[0m"

    # Prompt user for source directory
    read -p "Enter source directory: " SOURCE_DIR

    echo "1. Perform RSYNC"
    echo "2. Exit"
    read -r -p "Enter your choice: " choice

    case $choice in
        1)
            perform_rsync "$SOURCE_DIR" "$DEST_DIR"
            ;;
        2)
            echo "Exiting..."
            perform_unmount
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac
done
