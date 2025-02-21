#!/bin/sh

# Partition the disk
sgdisk --zap-all /dev/sda
sgdisk --new=1:0:+512M --typecode=1:ef00 /dev/sda
sgdisk --new=2:0:0 --typecode=2:8300 /dev/sda

# Format the partitions
mkfs.vfat -F 32 /dev/sda1
mkfs.F2FS /dev/sda2

# Mount the partitions
mount /dev/sda2 /mnt
mkdir -p /mnt/boot
mount /dev/sda1 /mnt/boot

# Generate the hardware configuration
nixos-generate-config --root /mnt

# Move the generated configuration
mv /mnt/etc/nixos/configuration.nix /mnt/etc/nixos/configuration.nix.orig

# Copy the hardware configuration file
cp hardware-configuration.nix /mnt/etc/nixos/

# Copy additional files
cp bluetooth.service /mnt/etc/nixos/
cp hardware-acceleration.nix /mnt/etc/nixos/
cp Read_me-configuration-nox.txt /mnt/etc/nixos/
cp configuration.nix /mnt/etc/nixos/
cp smb-secrets /mnt/etc/nixos/

# Install NixOS
sudo nixos-install

# Reboot the system
reboot
