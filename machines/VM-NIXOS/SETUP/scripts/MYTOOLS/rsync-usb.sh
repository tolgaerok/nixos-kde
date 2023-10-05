#!/bin/bash

# Tolga Erok
# Rsync to USB

# Function to display prompt

# Initialize the TEXT variable
TEXT=""

custom_prompt() {
    echo "Enter the $1 directory (e.g., $TEXT):"
    echo "┌──($USER@$HOST)-[$(pwd)]"
    read -p "└─\$>> " $2
    echo ""
}

# Prompt for source directory
TEXT="/etc/nixos/"
custom_prompt "source" SOURCE_DIR

# Prompt for destination directory
TEXT="/run/media/tolga/Medicat/Live_Operating_Systems/Linux/Nixos/"
custom_prompt "destination" DEST_DIR

start_time=$(date +%s)

# Function to perform rsync
perform_rsync_usb() {
    # Rsync
    echo "Syncing $SOURCE_DIR/ to $DEST_DIR ..."
    rsync -avz --progress --partial --bwlimit=500M --no-compress --no-relative --hard-links --update --stats "$SOURCE_DIR/" "$DEST_DIR"
    echo "Finished syncing $SOURCE_DIR/ to $DEST_DIR"
    sleep 1
    echo

    end_time=$(date +%s)
    time_taken=$((end_time - start_time))

    notify-send --app-name="Script Timer" "Script Execution Complete" "Time taken: $time_taken seconds" -u normal
}

# Unmount all
perform_unmount() {
    sudo umount -f /mnt/*
    sudo umount -l /mnt/*
}

perform_unmount
perform_rsync_usb
