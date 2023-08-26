#!/bin/bash

# Tolga Erok

# Source and destination information
DEST_DIR="/run/media/tolga/Medicat/Backup/"
SOURCE_DIR="/home/tolga/TEST"
start_time=$(date +%s)

# Function to perform rsync
perform_rsync() {
    # Rsync
    echo -e "\e[1;34mSyncing $SOURCE_DIR/ to $DEST_DIR ..."
    rsync -avz --progress --partial --bwlimit=500M --no-compress --relative --hard-links --update --stats "$SOURCE_DIR/" "$DEST_DIR"
    echo -e "Finished syncing $SOURCE_DIR/ to $DEST_DIR" | ${pkgs.cowsay}/bin/cowsay | ${pkgs.lolcat}/bin/lolcat
    sleep 1
    echo   

    end_time=$(date +%s)
    time_taken=$((end_time - start_time))

    notify-send --app-name="Script Timer" "Script Execution Complete" "Time taken: $time_taken seconds" -u normal
}



perform_rsync
