#!/bin/bash

# Tolga Erok  26/6/2023 Create Basic files and folders for current user for NixOS 23.05

# Find the sudo user and group
sudo_user="$SUDO_USER"
sudo_group=$(id -gn "$sudo_user")
current_user="$SUDO_USER"
current_user_home="/home/$current_user"
pictures_dir="$current_user_home/Pictures"
fontsDir="$current_user_home/.local/share/fonts"

# Set ownership and permissions for user's home directory
sudo chown -R "$sudo_user:$sudo_group" "/home/$sudo_user"
sudo chmod 755 "/home/$sudo_user"

# Create necessary directories with appropriate permissions
directories=(
  "/home/$sudo_user/.fonts"
  "/home/$sudo_user/.config"
  "/home/$sudo_user/.local/bin"
  "/home/$sudo_user/Documents"
  "/home/$sudo_user/Downloads"
  "/home/$sudo_user/Pictures"
  "/home/$sudo_user/Music"
  "/home/$sudo_user/Videos"
  "/home/$sudo_user/Public"
)

for dir in "${directories[@]}"; do
  if [ ! -d "$dir" ]; then
    sudo mkdir -p "$dir"
    sudo chown "$sudo_user:$sudo_group" "$dir"
    sudo chmod 755 "$dir"
  fi
done

# Create empty files with appropriate permissions
files=(
  "/home/$sudo_user/.bashrc"
  "/home/$sudo_user/.bash_profile"
  "/home/$sudo_user/.xinitrc"
  "/home/$sudo_user/.Xresources"
  "/home/$sudo_user/.xsession"
)

for file in "${files[@]}"; do
  if [ ! -f "$file" ]; then
    sudo touch "$file"
    sudo chown "$sudo_user:$sudo_group" "$file"
    sudo chmod 644 "$file"
  fi
done

# Add Flathub remote if not already added
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Define the array of applications
apps=(
  "com.sindresorhus.Caprine"
  "org.audacityteam.Audacity"
  "org.gnome.Rhythmbox3"
)

# Install and run each application
for app in "${apps[@]}"; do
  flatpak install flathub "$app" -y
  # flatpak run "$app" -y
done

# Create directories
sudo mkdir -p /mnt/smb-rsync
sudo mkdir -p /mnt/smb-budget
sudo mkdir -p /mnt/nixos_share
sudo mkdir -p /home/NixOs-KDE
sudo mkdir -p "$pictures_dir/CustomWallpapers"
sudo mkdir -p "$fontsDir"

# Add permissions
sudo chmod 777 /mnt/smb-rsync
sudo chmod 777 /mnt/smb-budget
sudo chmod 777 /mnt/nixos_share
sudo chmod 770 /home/NixOs-KDE

# Create samba user and group
echo "Add samba group"
sudo groupadd samba
sudo useradd -m tolga
echo ""
echo "Set and add tolga to samba group"
sudo smbpasswd -a tolga
sudo usermod -aG samba tolga
sudo chgrp samba /home/NixOs-KDE
sudo groupadd -r sambashare
sudo chown root:sambashare /var/lib/samba/usershares
sudo chmod 1770 /var/lib/samba/usershares
sudo gpasswd sambashare -a tolga
sudo usermod -aG sambashare tolga

# Mount and check
sudo mount -a || { echo "Mount failed"; exit 1; }
sudo ls /mnt/nixos_share || { echo "Failed to list Linux data"; exit 1; }

sudo systemctl daemon-reload

# Copy custom wallpapers 
cp -r "$(dirname "$(readlink -f "$0")")/WALLPAPERS"/* "$pictures_dir/CustomWallpapers"

# chown of current user to the newly created pictures folder
if [ -d "$pictures_dir" ]; then
  chown -R --reference="$pictures_dir" "$pictures_dir/CustomWallpapers"
fi

# Install fonts
cp "$(dirname "$(readlink -f "$0")")/FONTS/"* "$fontsDir"
chown -R "$current_user" "$fontsDir"
fc-cache -f "$fontsDir"

# Update font cache
echo "Updating font cache..."
fc-cache -f "$fontsDir"

# Define the configuration
config='
boot.initrd.availableKernelModules = [
  "xhci_pci"
  "ehci_pci"
  "ahci"
  "usbhid"
  "usb_storage"
  "sd_mod"
  "sr_mod"
  "uas"
];

boot.kernelParams = [ "mitigations=off" ];

fileSystems."/mnt/nixos_share" = {
  device = "//192.168.0.20/LinuxData/HOME/PROFILES/NIXOS-23-05/TOLGA/";
  fsType = "cifs";
  options = let
    automountOpts =
      "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,x-systemd.requires=network.target";
    uid =
      "1000"; # Replace with your actual user ID, use `id -u <YOUR USERNAME>` to get your user ID
    gid =
      "100"; # Replace with your actual group ID, use `id -g <YOUR USERNAME>` to get your group ID
    vers = "3.1.1";
    cacheOpts = "cache=loose";
    credentialsPath = "/etc/nixos/smb-secrets";
  in [
    "${automountOpts},credentials=${credentialsPath},uid=${uid},gid=${gid},vers=${vers},${cacheOpts}"
  ];
};

networking.interfaces.wlp3s0.useDHCP = true;
'

# Echo the configuration to hardware-configuration.nix
echo "$config" | sudo tee /etc/nixos/hardware-configuration.nix >/dev/null
