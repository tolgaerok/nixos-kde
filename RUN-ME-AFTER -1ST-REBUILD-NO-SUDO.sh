#!/usr/bin/env bash
#!/bin/bash
start_time=$(date +%s)

# Install notify agents
nix-env -iA nixos.libnotify
nix-env -iA nixos.notify-desktop

# Install Samba
nix-env -iA nixos.cifs-utils
nix-env -iA nixos.samba4Full

# Paths
font_folder="/etc/nixos/SETUP/fonts"
font_dest="/home/$(whoami)/.local/share/fonts"

script_folder="/etc/nixos/SETUP/scripts"
script_dest="/home/$(whoami)"

wallpapers_src="/etc/nixos/SETUP/wallpapers"
wallpapers_dest="/home/$(whoami)/Pictures"

# Create destination folders if they don't exist
mkdir -p "$font_dest"
mkdir -p "$script_dest"
mkdir -p "$wallpapers_dest"

# Move the fonts folder and its contents
cp -r "$font_folder" "$font_dest"
notify-send --icon=font-collection --app-name="DONE" "Fonts folder copied into $(whoami)" "$font_dest" -u normal

# Move the scripts folder and its contents
cp -r "$script_folder" "$script_dest"
notify-send --icon=text-x-script --app-name="DONE" "Script folder copied into $(whoami)" "$script_dest" -u normal

# Move the wallpapers folder and its contents
cp -r "$wallpapers_src" "$wallpapers_dest"
notify-send --icon=litedesktop --app-name="DONE" "Wallpaper folder moved into $(whoami)" "$wallpapers_dest" -u normal

# Set permissions for the destination folders and their contents
chmod -R +x "$font_dest"
chmod -R +x "$script_dest"
chmod -R +w "$wallpapers_dest"

# Get user and group of the current user
user_name=$(whoami)
user_group=$(id -gn "$user_name")

# Set ownership to the user and user's group
chown -R "$user_name":"$user_group" "$font_dest"
chown -R "$user_name":"$user_group" "$script_dest"
chown -R "$user_name":"$user_group" "$wallpapers_dest"

echo "Scripts, fonts and wallpapers folders have been moved to your home directory and permissions set."

end_time=$(date +%s)
time_taken=$((end_time - start_time))

notify-send --icon=ktimetracker --app-name="Post set-up" "Basic set-up Complete" "Time taken: $time_taken seconds" -u normal

# Change directory to the SETUP directory
cd SETUP

# Change the permissions of location
sudo chmod -R o+rw /etc/nixos/

nix-channel --update nixos
nix-env -u '*'
nix-shell -p samba4Full
nix-shell -p cifs-utils

# Run the script PART-B-WITH-SUDO.sh with superuser privileges
sudo ./PART-B-WITH-SUDO.sh
