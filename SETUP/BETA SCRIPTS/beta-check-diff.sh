#!/bin/bash

# Personal nixos folder archiver backup via differences
# Compare my current NixOS configuration with the last backup. If there are no differences, exit
# Or, start back up

# Tolga Erok. ¯\_(ツ)_/¯
# 19/9/2023

# My NixOS configuration directory
nixos_config_path="/etc/nixos"

# My path to backup folder
backup_folder="/etc/nixos/NIXOS-ARCHIVES"

# Function to check if there are differences
check_for_differences() {
    diff -r "$1" "$2"
}

# Check for differences between the currant configurition and the last backuup
if ! check_for_differences "$nixos_config_path" "$backup_folder"; then
    echo "No changes detected. No backup performed."
    exit 0
fi

# Changes detected, create a backup!
current_date=$(date +"%Y-%m-%d_%H-%M-%S")
backup_filename="backup_$current_date.zip"
mkdir -p "$backup_folder"
zip -r "$backup_folder/$backup_filename" "$nixos_config_path"

echo "Backup completed and stored in $backup_folder/$backup_filename"
