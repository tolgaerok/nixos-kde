#!/usr/bin/env bash
#!/run/current-system/sw/bin/bash

# Personal nixos post set-up!
# Tolga Erok. ¯\_(ツ)_/¯
# 20/8/23.

# control how the script behaves when certain conditions are met
#set -eux

RED='\e[1;31m'
GREEN='\e[1;32m'
YELLOW='\e[1;33m'
BLUE='\e[1;34m'
CYAN='\e[1;36m'
WHITE='\e[1;37m'
ORANGE='\e[1;93m'
NC='\e[0m'

if [ "$(id -u)" -eq 0 ]; then
  echo -e "\n${RED}[✘]${NC} ${YELLOW} ERROR! ${NC} $(basename "$0") should be run as a ${GREEN}regular${NC} user\n"
  exit 1
fi

# nix-shell -p espeak-classic
start_time=$(date +%s)
current_dir=$(pwd)
clear

#nix-shell -p # espeak-classic
espeak -v en+m7 -s 165 "Welcome! This script will! initiate! the! basic! setup! for your system. Thank you for using! my configuration." --punct=","

# Install notify agents
nix-env -iA nixos.libnotify
nix-env -iA nixos.notify-desktop

# espeak -v en+m7 -s 165 "Copying!   fonts!    wallpapers!   and    creating!  the!   basic!   setup! for   your     system. " --punct=","

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

# espeak -s 165 "Copying! fonts! wallpapers! " --punct=","

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
chmod -R u+rw "$font_dest"
chmod -R u+rw "$script_dest"
chmod -R u+rw "$wallpapers_dest"

# Get user and group of the current user
user_name=$(whoami)
user_group=$(id -gn "$user_name")

# Set ownership to the user and user's group
chown -R "$user_name":"$user_group" "$font_dest"
chown -R "$user_name":"$user_group" "$script_dest"
chown -R "$user_name":"$user_group" "$wallpapers_dest"

espeak -v en-us+m7 -s 165 "Scripts, fonts! and wallpapers! have been moved! to your home directory! and permissions set."
echo "Scripts, fonts and wallpapers folders have been moved to your home directory and permissions set."

end_time=$(date +%s)
time_taken=$((end_time - start_time))

notify-send --icon=ktimetracker --app-name="Post set-up" "Basic set-up Complete" "Time taken: $time_taken seconds" -u normal

# Change directory to the SETUP directory
cd /etc/nixos/SETUP

# Check if the 59-minute cron job already exists in the crontab
if ! crontab -l | grep -q "*/59 * * * * nixos-archive >> /home/tolga/test.log"; then
  # Add the 59-minute cron job to the crontab
  echo "*/59 * * * * nixos-archive >> /home/tolga/test.log" | crontab -
  echo "Cron job added successfully to run every 59 minutes."
else
  echo "Cron job already set to run every 59 minutes in the crontab."
fi

notify-send --icon=gtk-help --app-name="Cron setup" "Cron job added" "Time taken: $time_taken seconds" -u normal

# Change the permissions of location
sudo chmod -R o+rw /etc/nixos/
sudo chmod -R "$user_name":users /etc/nixos

# Run the script PART-B-WITH-SUDO.sh with superuser privileges

# yellow='\033[1;33m'  # Define yellow color
# reset='\033[0m'      # Reset text color
# sudo echo -e "${yellow}[!]${reset}[Running Part (B) ...]" && sudo konsole -T "Post setup for $user_name " -geometry 1099x530 -e "/etc/nixos/SETUP/My-SSH.sh"

# espeak -s 165 "Initiating!   Part 2!   setup!   stand!       by!"
sudo ./PART-B-WITH-SUDO.sh

# Return to the original directory
cd "$current_dir"
