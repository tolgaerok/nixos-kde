#!/bin/sh

# Move the generated configuration
mv /mnt/etc/nixos/configuration.nix /mnt/etc/nixos/configuration.nix.orig

# Copy the hardware configuration file

# Copy additional files

mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
swapon /dev/sda2
# Generate the hardware configuration
cp configuration.nix /mnt/etc/nixos/
nixos-generate-config --root /mnt

# Install NixOS
nixos-install
useradd -c 'tolga' -m tolga
passwd tolga

# Reboot the system

