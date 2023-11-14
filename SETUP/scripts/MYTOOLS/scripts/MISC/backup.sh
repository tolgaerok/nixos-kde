#!/usr/bin/env bash

# Set script to fail if any command fails or if any variable is used unset
set -eu

# Change to the directory of the script
cd "$(dirname "$(readlink -f "$0")")"

# Initialize Borg repository (assuming it's already created as you mentioned)
# borg init --encryption=repokey /home/tolga/Applications/borg

# Define the repository path
export REPOSITORY='/home/tolga/Applications/borg'

# Define the Borg executable path
export BORG_REMOTE_PATH="$REPOSITORY/borg"

# Create a backup
$BORG_REMOTE_PATH create -vxp --stats \
  --compression zstd \
  $REPOSITORY::'{hostname}-{now:%Y-%m-%dT%H:%M:%S}' \
  /home/tolga/Pictures \ # Modify the path to your desired backup source
  --exclude '/home/*/.cache' \
  --exclude '/home/*/tmp'

# Prune old backups
$BORG_REMOTE_PATH prune -v --list $REPOSITORY --prefix '{hostname}-' \
  --keep-daily=7 --keep-weekly=8 --keep-monthly=24 \
  | grep -v '^Keeping archive:'
