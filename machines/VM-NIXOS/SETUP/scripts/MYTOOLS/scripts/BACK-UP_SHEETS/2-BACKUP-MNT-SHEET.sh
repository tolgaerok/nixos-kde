#!/bin/bash
#####################################################################################################################################
#       Backup budget sheet > mount point on W11                                                                                    #
#       Tolga Erok
#       May 29, 2023
#       This script performs a backup by compressing files from a source directory and copying them to a destination directory.
#       The backup is saved with a filename based on the current date and time.
#       The script mounts an SMB share to the /mnt/nixos_share directory to facilitate the backup copy.
#       It creates the necessary directory structure in the destination directory based on the current date.
#       The script provides feedback on the success or failure of each step and displays relevant information at the end.
#       It waits for 3 seconds before exiting.
#       Function to mount a directory...
#                                                                                                                                   #
#####################################################################################################################################

backup_SRC="/mnt/nixos_share/Documents/[ BUDGET 2023 ]/ARCHIEVES/"
backup_DST="//192.168.0.20/LinuxData/BUDGET-ARCHIVE/" # Update with the correct SMB share path
#backup_DST="//192.168.0.20/LinuxData/BUDGET-ARCHIVE/"
backup_file="$(date +'%a - %b %d - %Y - %I-%M-%S %p').7z"

# Extract the year, month, and day from the current date
year=$(date +'%Y')
month=$(date +'%b')
day=$(date +'%a %d')

# Create the destination directory if it doesn't exist
sudo mkdir -p "$backup_DST/$year/$month/$day"

echo "Starting backup..."
7z a "/tmp/$backup_file" "$backup_SRC"
if [ $? -ne 0 ]; then
    echo "Backup failed."
    exit 1
fi

echo "Copying backup to destination directory..."
if [ ! -d "/mnt/nixos_share" ]; then
    sudo mkdir "/mnt/nixos_share"
fi

# sudo mount -t cifs -o username=tolga,password=ibm450,vers=1.0 "$backup_DST" /mnt/nixos_share  # Update with the correct SMB share path
sudo mount -t cifs -o username=tolga,password=ibm450,vers=3.0 "$backup_DST" /mnt/nixos_share

if [ $? -ne 0 ]; then
    echo "Failed to mount SMB share."
    exit 1
fi

sudo mkdir -p "/mnt/nixos_share/$year"
sudo mkdir -p "/mnt/nixos_share/$year/$month"
sudo mkdir -p "/mnt/nixos_share/$year/$month/$day"

sudo cp "/tmp/$backup_file" "/mnt/nixos_share/$year/$month/$day/$backup_file"
if [ $? -ne 0 ]; then
    echo "Failed to copy backup to destination directory."
    exit 1
fi

sudo umount -f /mnt/nixos_share
if [ $? -ne 0 ]; then
    echo "Failed to unmount SMB share."
    exit 1
fi

clear

echo "Backup complete."

echo "Output directories:"
echo "Source: $backup_SRC
"
echo "Destination: $backup_DST/$year/$month/$day
"
echo "Backup file name: $backup_file
"

echo "Full directory path and commands used:
"
echo "Source directory: $backup_SRC
"
echo "Destination directory: $backup_DST/$year/$month/$day"
echo "Backup command: 7z a /tmp/$backup_file $backup_SRC"
echo "Mount command: sudo mount -t cifs -o username=tolga,password=ibm450,vers=3.0 $backup_DST /mnt/nixos_share"
echo "Copy command: sudo cp /tmp/$backup_file /mnt/nixos_share/$year/$month/$day/$backup_file"
echo "Unmount command: sudo umount -f /mnt/nixos_share"
