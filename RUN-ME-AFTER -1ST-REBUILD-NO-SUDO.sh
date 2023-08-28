#!/usr/bin/env bash
#!/bin/bash
start_time=$(date +%s)

# Paths
script_folder="/etc/nixos/SETUP/scripts"
script_dest="/home/$(whoami)"
wallpapers_src="/etc/nixos/SETUP/wallpapers"
wallpapers_dest="/home/$(whoami)/Pictures"

# Create destination folders if they don't exist
mkdir -p "$script_dest"
mkdir -p "$wallpapers_dest"

# Move the scripts folder and its contents
cp -r "$script_folder" "$script_dest"
notify-send --app-name="DONE" "Script folder copied into $(whoami)" "/home directory" -u normal

# Move the wallpapers folder and its contents
cp -r "$wallpapers_src" "$wallpapers_dest"
notify-send --app-name="DONE" "Wallpaper folder moved into $(whoami)" "/Pictures directory" -u normal

# Set permissions for the destination folders and their contents
chmod -R +x "$script_dest"
chmod -R +w "$wallpapers_dest"

# Get user and group of the current user
user_name=$(whoami)
user_group=$(id -gn "$user_name")

# Set ownership to the user and user's group
chown -R "$user_name":"$user_group" "$script_dest"
chown -R "$user_name":"$user_group" "$wallpapers_dest"

echo "Scripts and wallpapers folders have been moved to your home directory and permissions set."

end_time=$(date +%s)
time_taken=$((end_time - start_time))

notify-send --app-name="Script Timer" "Script Execution Complete" "Time taken: $time_taken seconds" -u normal

# Change directory to the SETUP directory
cd /SETUP

nix-channel --update nixos
nix-env -u '*'
nix-shell -p samba4Full
nix-shell -p cifs-utils

# Run the script PART-B-WITH-SUDO.sh with superuser privileges
sudo ./PART-B-WITH-SUDO.sh

