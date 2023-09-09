#!/bin/bash
# Personal nixos folder archiver backup
# Tolga Erok. ¯\_(ツ)_/¯
# 20/8/23.

# Define the backup folder path within /etc/nixos
backup_folder="/etc/nixos/NIXOS-ARCHIVES"

# Get the current date and time in the required format
current_date=$(date +"%Y %b %a, %l:%M%p")
backup_subfolder=$(date +"%Y/%b/%a,%l:%M%p")

# Create the backup folder structure if it doesn't exist
mkdir -p "$backup_folder/$backup_subfolder"

# Define the backup filename without extension
backup_filename=$(date +"%a,%l:%M%p")

# Zip the contents of /etc/nixos without the folder structure
zip -r "$backup_folder/$backup_subfolder/$backup_filename.zip" /etc/nixos/*

echo "Backup completed and stored in $backup_folder/$backup_subfolder/$backup_filename.zip"
