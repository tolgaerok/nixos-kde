#!/bin/bash

# Tolga Erok

# Configuration file to store user inputs
CONFIG_FILE="$HOME/.rsync_config"

# Function to load configuration values or ask for user input
load_config() {
    if [ -f "$CONFIG_FILE" ]; then
        source "$CONFIG_FILE"
    else
        echo "Config file not found. Please provide the following information:"
        read -p "Server IP: " SERVER_IP
        read -p "Source Directory: " SOURCE_DIR

        # Save user inputs to the config file
        echo "SERVER_IP=\"$SERVER_IP\"" > "$CONFIG_FILE"
        echo "SOURCE_DIR=\"$SOURCE_DIR\"" >> "$CONFIG_FILE"
    fi
}

# Load configuration or ask for user input
load_config

# Source and destination information
start_time=$(date +%s)

# Function to perform rsync
perform_rsync() {
    read -p "Enter the source directory: " SOURCE_DIR
    read -p "Enter the destination directory: " DEST_DIR
    read -p "Enter the server IP address: " SERVER_IP

    # Mount options
    MOUNT_OPTIONS="credentials=/etc/nixos/system/network/smb-secrets,uid=$USER,gid=samba,vers=3.1.1,cache=loose,file_mode=0777,dir_mode=0777"

    # Mount smb share
    sudo mount -t cifs //$SERVER_IP/LINUXDATA2/ISO/RSYNC/ "$DEST_DIR" -o "$MOUNT_OPTIONS"

    # Rsync
    echo -e "\e[1;34mSyncing $SOURCE_DIR/ $DEST_DIR/ ..."
    rsync -av --progress --partial --bwlimit=500M --no-compress --relative --hard-links --update --stats --exclude='.git*' "$SOURCE_DIR/" "$DEST_DIR/"
    echo -e "Finished syncing $SOURCE_DIR/ $DEST_DIR/"
    sleep 1
    echo

    # Display last update details
    last_update=$(date "+%Y-%m-%d %H:%M:%S")
    data_size=$(du -sh "$DEST_DIR" | cut -f1)
    echo -e "Last Update: $last_update, Data Size: $data_size"

    end_time=$(date +%s)
    time_taken=$((end_time - start_time))

    notify-send --icon=ktimetracker --app-name="Post set-up" "Basic set-up Complete" "Time taken: $time_taken seconds" -u normal
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


# --------------------------------------------------------------------
# Automated System Enhancements
# --------------------------------------------------------------------

# Enable automatic system upgrades and reboots if necessary
# system.autoUpgrade.allowReboot = true;
system.autoUpgrade.enable = true;
system.copySystemConfiguration = true;
systemd.extraConfig = "DefaultTimeoutStopSec=10s";