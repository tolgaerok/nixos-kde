#!/usr/bin/env bash

# Tolga Erok
# 14/7/2023

sudo NIXPKGS_ALLOW_UNFREE=1 nix-shell -p hplipWithPlugin --run 'sudo -E hp-setup'
sudo smbpasswd -a tolga && sudo groupadd samba && sudo usermod -aG samba tolga
sudo mkdir -p /mnt/Budget-Archives
sudo mkdir -p /mnt/home-profiles
sudo mkdir -p /mnt/linux-data
sudo mkdir -p /mnt/smb
sudo mkdir -p /mnt/smb-budget
sudo mkdir -p /mnt/smb-rsync
sudo mkdir -p /mnt/windows-data
sudo chmod 777 /mnt/Budget-Archives
sudo chmod 777 /mnt/home-profiles
sudo chmod 777 /mnt/linux-data
sudo chmod 777 /mnt/smb
sudo chmod 777 /mnt/smb-budget
sudo chmod 777 /mnt/smb-rsync
sudo chmod 777 /mnt/windows-data
sudo mkdir -p /home/NixOs-KDE
sudo chmod 0757 /home/NixOs-KDE

# run after sudo nixos-rebuild switch
sudo nix-channel --update
sudo nix-env --upgrade
sudo nixos-rebuild switch
sudo nix-store --optimise
