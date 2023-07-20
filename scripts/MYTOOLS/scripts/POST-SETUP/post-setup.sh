#!/usr/bin/env bash

# Tolga Erok
# 14/7/2023
sudo -u tolga mkdir -p /home/tolga/Pictures
sudo -u tolga mkdir -p /home/tolga/Videos
sudo -u tolga mkdir -p /home/tolga/Music
sudo -u tolga mkdir -p /home/tolga/Documents
# Add more directories as needed.
sudo chown tolga:users /home/tolga/Pictures
sudo chown tolga:users /home/tolga/Videos
sudo chown tolga:users /home/tolga/Music
sudo chown tolga:users /home/tolga/Documents
# Add more directories as needed.

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

sudo NIXPKGS_ALLOW_UNFREE=1 nix-shell -p hplipWithPlugin --run 'sudo -E hp-setup'

echo "Install samba and create user/group"

# Prompt for the desired username for samba
read -p $'\n'"Enter the USERNAME to add to Samba: " sambausername

# Prompt for the desired name for samba
read -p $'\n'"Enter the GROUP name to add username to Samba: " sambagroup

sudo groupadd $sambagroup
sudo useradd -m $sambausername
sudo smbpasswd -a $sambausername
sudo usermod -aG $sambagroup $sambausername

echo "
Continuing..."
read -r -n 1 -s -t 1

sudo smbpasswd -a tolga 
sudo groupadd samba 
sudo usermod -aG samba tolga

sudo mkdir -p /home/NixOs-KDE
sudo chgrp samba /home/NixOs-KDE
sudo chmod 0757 /home/NixOs-KDE

read -r -p "
Continuing..." -t 1 -n 1 -s

# Configure usershares plugin
read -r -p "Create and configure the Samba Filesharing Plugin ...
" -t 3 -n 1 -s

# Prompt for the desired username
read -p $'\n'"Enter the username to configure Samba Filesharing Plugin for: " username

# Set umask value
umask 0002

# Set the shared folder path
shared_folder="/home/$username"

# Set permissions for the shared folder and parent directories (excluding hidden files and .cache directory)
find "$shared_folder" -type d ! -path '/.' ! -path '/.cache' -exec chmod 0757 {}
2>/dev/null

# Create the sambashares group if it doesn't exist
sudo groupadd -r sambashares

# Create the usershares directory and set permissions
sudo mkdir -p /var/lib/samba/usershares
sudo chown $username:sambashares /var/lib/samba/usershares
sudo chmod 1770 /var/lib/samba/usershares

# Restore SELinux context for the usershares directory
sudo restorecon -R /var/lib/samba/usershares

# Add the user to the sambashares group
sudo gpasswd sambashares -a $username

# Add the user to the sambashares group (alternative method)
sudo usermod -aG sambashares $username

# Set permissions for the user's home directory
sudo chmod 0757 /home/$username

# Path to alias script
main_script="./setup-alias.sh"

# Check if the main script exists
if [[ -e "$main_script" ]]; then
  # Execute the main script using source
  source "$main_script"
else
  echo "Main script not found: $main_script"
fi


# run after sudo nixos-rebuild switch
sudo nix-channel --update
sudo nixos-rebuild switch
sudo nix-store --optimise

# Not too sure ones:
#sudo nix-env --upgrade
#sudo mkdir -p /mnt/Budget-Archives
#sudo mkdir -p /mnt/home-profiles
#sudo mkdir -p /mnt/linux-data
#sudo mkdir -p /mnt/smb
#sudo mkdir -p /mnt/smb-budget
#sudo mkdir -p /mnt/smb-rsync
#sudo mkdir -p /mnt/windows-data
#sudo chmod 777 /mnt/Budget-Archives
#sudo chmod 777 /mnt/home-profiles
#sudo chmod 777 /mnt/linux-data
#sudo chmod 777 /mnt/smb
#sudo chmod 777 /mnt/smb-budget
#sudo chmod 777 /mnt/smb-rsync
#sudo chmod 777 /mnt/windows-data

source #HOME/.bashrc
#alias mynix='sudo ~/scripts/MYTOOLS/scripts/COMMAN-NIX-COMMAND-SCRIPT/MyNixOS-commands.sh'
#alias mount='sudo ~/scripts/MYTOOLS/scripts/Mounting-Options/MOUNT-ALL.sh'
#alias umount='sudo ~/scripts/MYTOOLS/scripts/Mounting-Options/UMOUNT-ALL.sh'
#alias mse='sudo ~/scripts/MYTOOLS/MAKE-SCRIPTS-EXECUTABLE.sh'
#alias htos='sudo ~/scripts/MYTOOLS/scripts/Zysnc-Options/ZYSNC-HOME-TO-SERVER.sh'
#alias stoh='sudo ~/scripts/MYTOOLS/scripts/Zysnc-Options/ZYSNC-SERVER-TO-HOME.sh'
#{ config, pkgs, ... }:


# {
#  users.users.root = {
#    shell = pkgs.mkShell {
 #     buildInputs = [ pkgs.bashInteractive ];
 #     shellHook = ''
#        echo "Setting up root shell environment"
#        echo "alias tolga='sudo /home/tolga/scripts/MYTOOLS/scripts/COMMAN-NIX-COMMAND-SCRIPT/MyNixOS-commands.sh'" >> $HOME/.profile
#      '';
#    };
#  };
# }

