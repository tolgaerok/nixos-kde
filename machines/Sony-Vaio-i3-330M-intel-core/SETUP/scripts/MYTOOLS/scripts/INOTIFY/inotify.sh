#!/bin/bash


# Tolga Erok 
# 18/8/23

# Set source and destination paths
SOURCE_DIR="/home/tolga/Templates/"
DEST_REPO="/home/tolga/nixos/nixos/"

# Function to handle git operations and push changes
commit_and_push() {
    # Get the current date and time
    current_datetime=$(date +"%Y-%m-%d %H:%M:%S")

    # Add all changed files to the staging area
    git add .

    # Commit changes with date and time
    git commit -m "Automated changes: $filename - $current_datetime"

    # Push the changes to GitHub (adjust the remote and branch as needed)
    git remote set-url origin "$DEST_REPO"
    git push origin main
}

# Start inotifywait to monitor changes
while true; do
    inotifywait -e modify,create,delete -r "$SOURCE_DIR"
    
    # Remove the index lock file if it exists
    rm -f "$DEST_REPO/.git/index.lock"

    # Wait for any existing Git process to finish
    while [[ -f "$DEST_REPO/.git/index.lock" ]]; do
        sleep 1
    done
    
    # Navigate to the repo directory or exit if navigation fails
    cd "$DEST_REPO" || exit

    # Prompt for automatic staging and committing
    read -r -p "Automatic staging and committing? (y/n): " choice < /dev/tty
    if [[ "$choice" == [Yy] ]]; then
        # Copy the changed files to the local repo
        cp -r "$SOURCE_DIR" "$DEST_REPO"
        filename="Multiple files"
        commit_and_push
    else
        echo "Changes saved. You can commit and push later."
    fi
done
