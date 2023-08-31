#!/usr/bin/env bash

# Personal nixos post set-up!
# Tolga Erok. ¯\_(ツ)_/¯
# 20/8/23.

start_time=$(date +%s)
current_dir=$(pwd)
clear

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

# Check if font_dest exists
if [ -d "$font_dest" ]; then

    # Copy contents of font_folder into font_dest
    cp -r "$font_folder"/* "$font_dest/"
    echo "Contents of $font_folder copied to $font_dest"
    notify-send --icon=font-collection --app-name="DONE" "Fonts folder copied into $(whoami)" "$font_dest" -u normal
else
    echo "$font_dest does not exist. Creating it..."
    mkdir -p "$font_dest"
    cp -r "$font_folder"/* "$font_dest/"
    echo "Contents of $font_folder copied to $font_dest"
fi

mkdir -p "$script_dest"
mkdir -p "$wallpapers_dest"

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
cd /etc/nixos/SETUP

# Change the permissions of location
sudo chmod -R o+rw /etc/nixos/

# Run the script PART-B-WITH-SUDO.sh with superuser privileges
sudo ./PART-B-WITH-SUDO.sh

# Return to the original directory
cd "$current_dir"
