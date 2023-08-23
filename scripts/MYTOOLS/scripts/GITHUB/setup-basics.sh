#!/usr/bin/env bash

# Tolga Erok
# 14/7/2023

# My personal post Nixos setup

# -----------------------------------------------------------------------------------
# Check if Script is Run as Root
# -----------------------------------------------------------------------------------

if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./setup-basics.sh" 2>&1
  exit 1
fi

# -----------------------------------------------------------------------------------
# Set some variables & functions
# -----------------------------------------------------------------------------------

# Location of private samba folder
shared_folder="/home/NixOs-KDE"

# Get the user and group names using the IDs
user_name=$(id -un "$user_id")
group_name=$(getent group "$group_id" | cut -d: -f1)

# Function to create directories if they don't exist and set permissions
create_directory_if_not_exist() {
  if [ ! -d "$1" ]; then
    mkdir -p "$1"
    echo "Created directory: $1"
    chmod 757 "$1" # Set full access (read, write, and execute) for user, group, and others
  fi
}

# Function to check and update permissions of existing directories
update_directory_permissions() {
  if [ -d "$1" ]; then
    perm=$(stat -c "%a" "$1")
    if [ "$perm" != "757" ]; then
      echo "Updating permissions of existing directory: $1"
      chmod 757 "$1"
    fi
  fi
}

# -----------------------------------------------------------------------------------
# Get user id an group id
# -----------------------------------------------------------------------------------

# Check if the script is run using sudo
if [ "$(id -u)" = "0" ] && [ -n "$SUDO_USER" ]; then
  # Get the original non-root user ID and group ID
  user_id=$(id -u "$SUDO_USER")
  group_id=$(id -g "$SUDO_USER")

  # Display the non-root user ID, name, and group ID
  echo "Non-Root User: $user_name (ID: $user_id)"
  echo "Non-Root Group: $group_name (ID: $group_id)"
else
  echo "This script should be run using sudo."
  exit 1
fi

# -----------------------------------------------------------------------------------
#  Create some directories and set permissions
# -----------------------------------------------------------------------------------

if [ -n "$user_name" ] && [ -n "$group_name" ]; then
  home_dir="/home/$user_name"
  config_dir="$home_dir/.config/nix"

  create_directory_if_not_exist "$home_dir"
  create_directory_if_not_exist "$config_dir"

  # Update directory permissions
  update_directory_permissions "$home_dir/Documents"
  update_directory_permissions "$home_dir/Music"
  update_directory_permissions "$home_dir/Pictures"
  update_directory_permissions "$home_dir/Public"
  update_directory_permissions "$home_dir/Templates"
  update_directory_permissions "$home_dir/Videos"

  # Set ownership for directories
  sudo chown -R "$user_name":"$group_name" "$home_dir"

  # Additional chown commands for directories
  create_directory_if_not_exist "$home_dir/Documents"
  create_directory_if_not_exist "$home_dir/Music"
  create_directory_if_not_exist "$home_dir/Pictures"
  create_directory_if_not_exist "$home_dir/Public"
  create_directory_if_not_exist "$home_dir/Templates"
  create_directory_if_not_exist "$home_dir/Videos"

  # Give full permissions to the nix.conf file
  echo "experimental-features  = nix-command flakes" | sudo -u "$user_name" tee "$config_dir/nix.conf"
  chmod 757 "$config_dir/nix.conf" # Set full access (read and write) for user, group, and others
else
  echo "Failed to retrieve non-root user and group information."
  exit 1
fi

# -----------------------------------------------------------------------------------
# Flatpak section
# -----------------------------------------------------------------------------------

echo "Install Flatpak apps..."

# Enable Flatpak
if ! flatpak remote-list | grep -q "flathub"; then
  sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
fi

# Update Flatpak
sudo flatpak update -y

echo "Updating cache, this will take a while..."

# Install Flatpak apps
packages=(
  com.sindresorhus.Caprine
  org.kde.kweather
)

# Install each package if not already installed
for package in "${packages[@]}"; do
  if ! flatpak list | grep -q "$package"; then
    echo "Installing $package..."
    sudo flatpak install -y flathub "$package"
  else
    echo "$package is already installed. Skipping..."
  fi
done

# Double check for the latest Flatpak updates and remove Flatpak cruft
sudo flatpak update -y
sudo flatpak uninstall --unused --delete-data -y

echo "Software install complete..."

# -----------------------------------------------------------------------------------
#  Create some SMB user and group
# -----------------------------------------------------------------------------------

# Function to read user input and prompt for input
prompt_input() {
  read -p "$1" value
  echo "$value"
}

# Create user/group
echo "Time to create smb user & group"

# Prompt for the desired username and group for Samba
sambausername=$(prompt_input $'\nEnter the USERNAME to add to Samba: ')
sambagroup=$(prompt_input $'\nEnter the GROUP name to add username to Samba: ')

# Create Samba user and group
sudo groupadd "$sambagroup"
sudo useradd -m "$sambausername"
sudo smbpasswd -a "$sambausername"
sudo usermod -aG "$sambagroup" "$sambausername"

# Pause and continue
echo -e "\nContinuing..."
read -r -n 1 -s -t 1

# Create and configure the shared folder

sudo mkdir -p "$shared_folder"
sudo chgrp samba "$shared_folder"
sudo chmod 0757 "$shared_folder"

# Pause and continue
read -r -p "Continuing..." -t 1 -n 1 -s

# Configure Samba Filesharing Plugin for a user
echo -e "\nCreate and configure the Samba Filesharing Plugin..."

# Prompt for the desired username to configure Samba Filesharing Plugin
username=$(prompt_input $'\nEnter the username to configure Samba Filesharing Plugin for: ')

# Set umask value
umask 0002

# Set permissions for the shared folder and parent directories (excluding hidden files and .cache directory)
find "$shared_folder" -type d ! -path '/.' ! -path '/.cache' -exec chmod 0757 {} \; 2>/dev/null

# Create the sambashares group if it doesn't exist
sudo groupadd -r sambashares

# Create the usershares directory and set permissions
sudo mkdir -p /var/lib/samba/usershares
sudo chown "$username:sambashares" /var/lib/samba/usershares
sudo chmod 1770 /var/lib/samba/usershares

# Restore SELinux context for the usershares directory
sudo restorecon -R /var/lib/samba/usershares

# Add the user to the sambashares group
sudo gpasswd sambashares -a "$username"

# Set permissions for the user's home directory
sudo chmod 0757 "/home/$username"

# Run the following commands after sudo nixos-rebuild switch
sudo nix-env --upgrade && sudo nix-store --optimise
sudo nixos-rebuild switch && sudo nix-collect-garbage --delete-old
sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot
