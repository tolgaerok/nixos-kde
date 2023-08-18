#!/bin/bash

# Set your source and destination paths
SOURCE_DIR="/home/tolga/nixos/nixos/"
DEST_REPO="https://github.com/tolgaerok/nixos.git"

# Start inotifywait to monitor changes
inotifywait -m -r -e modify,create,delete "$SOURCE_DIR" |
    while read -r directory events filename; do
        # Copy the changed file to the local repo
        cp "$SOURCE_DIR/$filename" "$DEST_REPO/$filename"

        # Navigate to the repo directory
        cd "$DEST_REPO"

        # Get the current date and time
        current_datetime=$(date +"%Y-%m-%d %H:%M:%S")

        # Add and commit the changes with date and time
        git add "$filename"
        git commit -m "Automated changes: $filename - $current_datetime"

        # Push the changes to GitHub (adjust the remote and branch as needed)
        git push origin main
    done
