#!/bin/bash

echo -e "\033[34m" # Set text color to blue
echo "Mounting all mount points"
echo -e "\033[1;37m"

# Function to mount a directory
mount_directory() {
    local dir="$1"

    # Check if the directory is already mounted
    if mountpoint -q "$dir"; then
        echo "$dir is already mounted"
        return 0
    fi

    # Mount the directory
    sudo mount "$dir"

    # Check if mounting was successful
    if ! mountpoint -q "$dir"; then
        echo "Mounting $dir failed"
        return 1
    fi

    return 0
}

# Mount all directories listed in /etc/fstab under /mnt
while IFS= read -r mount_point; do
    if [[ "$mount_point" =~ /mnt/ ]]; then
        mount_directory "$mount_point"
    fi
done < <(awk '$2 ~ /^\/mnt/ {print $2}' /etc/fstab)

# Mount all directories listed in /etc/fstab under /media
while IFS= read -r mount_point; do
    if [[ "$mount_point" =~ /media/ ]]; then
        mount_directory "$mount_point"
    fi
done < <(awk '$2 ~ /^\/media/ {print $2}' /etc/fstab)

# Check if any mounts failed
failed_mounts=false

if [[ $(mount | grep -E '^/mnt/|^/media/' | wc -l) -ne 0 ]]; then
    echo "Unable to mount all filesystems under /mnt and /media"
    failed_mounts=true
fi

if ! $failed_mounts; then
    echo -e "\033[1;33m"
    echo "Mounting done."
fi

exit 0
