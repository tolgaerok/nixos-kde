#!/usr/bin/env bash

# Tolga Erok
# 11/5/2023
# About:
#   Personal RSYNC script that only rsyncs selected folders listed in INCLUDE_FOLDERS variables
#   excluding ALL hidden files and folders from /home/tolga/ to //192.168.0.3/LinuxData/HOME/tolga
#

clear

SOURCE_DIR="/home/tolga/"
DEST_DIR="/mnt/smb-rsync/"
USERNAME="xxx"
PASSWORD="xxx"
SERVER_IP="192.168.0.20"

MOUNT_OPTIONS="credentials=/etc/nixos/network/smb-secrets,uid=1000,gid=100,vers=3.1.1,cache=loose,file_mode=0777,dir_mode=0777"

# Unmount smb share
sudo umount -f /mnt/*
sudo umount -l /mnt/*

# Reload daemon and fstab
sudo systemctl daemon-reload

while true; do
  # Menu options
  echo -e "\n\e[1;31mRSYNC from /home/tolga > W11: ---\e[0m"
  echo -e "\e[1;34mPlease select a Linux distribution profile:\e[0m"
  echo "1. Fedora"
  echo "2. NixOS"
  echo "3. RHEL 9.2"
  echo "4. Mint"
  echo "5. Start again"
  echo "6. Exit"
  read -p "Enter your choice: " choice

  case $choice in
  1)
    distro="FEDORA"
    ;;
  2)
    distro="NIXOS-23-05"
    ;;
  3)
    distro="RHEL-9"
    ;;
  4)
    distro="MINT"
    ;;
  5)
    clear
    continue
    ;;
  6)
    echo "Exiting..."
    exit 0
    ;;
  *)
    echo "Invalid choice. Please try again."
    continue
    ;;
  esac

  clear
  sudo mkdir -p $DEST_DIR
  sudo chmod 777 $DEST_DIR

  # Create mount point if it doesn't exist
  if [[ ! -d "$DEST_DIR" ]]; then
    sudo mkdir -p "$DEST_DIR"
  fi

  # Mount smb share
  # sudo mount -t cifs //$SERVER_IP/LinuxData/HOME/PROFILES/$distro/TOLGA $DEST_DIR -o credentials=/etc/nixos/network/smb-secrets,uid=1000,gid=100,vers=3.1.1,cache=loose,file_mode=0777,dir_mode=0777
  sudo mount -t cifs "//$SERVER_IP/LinuxData/HOME/PROFILES/$distro/TOLGA/" "$DEST_DIR" -o "credentials=/etc/nixos/network/smb-secrets,uid=$USER,gid=samba"

  # Check if the mount was successful
  if [ $? -eq 0 ]; then
    echo "SMB share mounted successfully."
  else
    echo "Failed to mount SMB share. Please check the error messages."
    exit 1
  fi

  # Rsync
  INCLUDE_FOLDERS=(
    "Desktop"
    "Documents"
    "Downloads"
    "Music"
    "Pictures"
    "Public"
    "Templates"
    "Videos"
  )

  EXCLUDE_DIRS=(
    ".*"
  )

  # Create the parent directory on the remote server (if it doesn't exist)
  for folder in "${INCLUDE_FOLDERS[@]}"; do
    sudo mkdir -p "//$SERVER_IP/LinuxData/HOME/PROFILES/$distro/TOLGA/$folder"
  done

  for folder in "${INCLUDE_FOLDERS[@]}"; do
    echo -e "\e[1;34mSyncing $folder...\e[0m"
    rsync -avz --progress --partial --bwlimit=500M --exclude="${EXCLUDE_DIRS[@]}" --update --info=progress2 --stats "$SOURCE_DIR/$folder/" "$DEST_DIR/$folder/"
    echo -e "\e[1;31mFinished syncing $folder\e[0m"
    echo
    sleep 1
    clear
  done

  # Reload daemon, fstab, and mount -a
  sudo systemctl daemon-reload && sudo mount -a

  # Show last update details for transferred folders
  echo -e "\e[1;34mLast update details for transferred folders:\e[0m\n"
  for folder in "${INCLUDE_FOLDERS[@]}"; do
    if [[ -d "$DEST_DIR/$folder" ]]; then
      last_update=$(stat -c "%y" "$DEST_DIR/$folder" | cut -d' ' -f1)
      data_size=$(du -sh "$DEST_DIR/$folder" | cut -f1)
      printf "%-12s - Last Update: %-10s, Data Size: %-10s\n" "$folder" "$last_update" "$data_size"
    fi
  done

  echo -e "\n\e[1;31mPress Enter to go back to the menu.\e[0m"
  read -s -r
  clear
done
