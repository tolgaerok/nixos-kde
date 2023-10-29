#!/usr/bin/env bash

#---------------------------------------------------------------------
# Tolga Erok
# 30/10/23
# My personal NIXOS installer to suit 500GiB SSD
#
# ¯\_(ツ)_/¯
#---------------------------------------------------------------------

# Define the target device (change this to match your system)
target_device="/dev/sda"

# Create a GPT partition table
parted "$target_device" mklabel gpt

# Create a 2 GiB boot partition (ESP - EFI System Partition)
parted "$target_device" mkpart ESP fat32 1MiB 2GiB
parted "$target_device" set 1 esp on

# Create a 120 GiB NixOS root partition formatted as F2FS
parted "$target_device" mkpart primary 2GiB 122GiB
mkfs.f2fs -l nixos "${target_device}p2"

# Create a home partition with the remaining space formatted as FAT32
parted "$target_device" mkpart primary 122GiB 100%
mkfs.fat -F 32 -n home "${target_device}p3"

# Mount the NixOS root partition
mount "${target_device}p2" /mnt

# Create a boot directory and mount the ESP partition
mkdir /mnt/boot
mount "${target_device}p1" /mnt/boot

# Create a home directory and mount the home partition
mkdir /mnt/home
mount "${target_device}p3" /mnt/home

# Generate a NixOS configuration 
sudo nixos-generate-config --root /mnt

# Install NixOS
sudo nixos-install

# Configure Nix flakes
mkdir -p /mnt/etc/nix
echo "experimental-features = nix-command flakes" | sudo tee -a /mnt/etc/nix/nix.conf

# Clone a Git repository and set up Home Manager (adjust as needed)
mkdir -p ~/s
cd ~/s
git clone git@github.com:NelsonJeppesen/nix-lifestyle.git

mkdir -p ~/.config
ln -s ~/s/nix-lifestyle/home-manager ~/.config/home-manager

# Add the Home Manager channel and update
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

# Activate Home Manager before the final reboot
nix-shell '<home-manager>' -A install

# Reboot the system
sudo reboot
