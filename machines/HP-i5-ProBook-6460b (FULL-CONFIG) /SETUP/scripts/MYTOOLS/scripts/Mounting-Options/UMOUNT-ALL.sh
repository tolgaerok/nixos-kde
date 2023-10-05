#!/bin/bash

echo -e "\033[34m" # Set text color to blue
echo "Unmounting all mount points"
echo -e "\033[1;37m"

# Function to unmount a directory
unmount_directory() {
  local dir="$1"

  # Check if the directory is already unmounted
  if ! mountpoint -q "$dir"; then
    echo "$dir is already unmounted"
    return 0
  fi
# Unmount smb share
sudo umount -f /mnt/*
sudo umount -l /mnt/*
# Unmount smb share
sudo umount -f /media/*
sudo umount -l /media/*
  # Unmount the directory
  sudo umount -lf "$dir"

  # Wait until the directory is unmounted
  while mountpoint -q "$dir"; do
    sleep 1
  done

  # Check if unmounting was successful
  if mountpoint -q "$dir"; then
    echo "Unmounting $dir failed"
    return 1
  fi

  return 0
}

# Unmount all directories listed in /etc/fstab under /mnt
while IFS= read -r mount_point; do
  if [[ "$mount_point" =~ /mnt/ ]]; then
    unmount_directory "$mount_point"
  fi
done < <(awk '$2 ~ /^\/mnt/ {print $2}' /etc/fstab)

# Unmount all directories listed in /etc/fstab under /media
while IFS= read -r mount_point; do
  if [[ "$mount_point" =~ /media/ ]]; then
    unmount_directory "$mount_point"
  fi
done < <(awk '$2 ~ /^\/media/ {print $2}' /etc/fstab)

# Check if any unmounts failed
failed_unmounts=false

if [[ $(mount | grep -E '^/mnt/|^/media/' | wc -l) -ne 0 ]]; then
  echo "Unable to unmount all filesystems under /mnt and /media"
  failed_unmounts=true
fi

if ! $failed_unmounts; then
  echo -e "\033[1;33m"
  echo "Unmounting done."
fi

exit 0
