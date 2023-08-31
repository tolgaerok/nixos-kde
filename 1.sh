#!/bin/bash

# Tolga

# Prompt user to select source location using file manager
source_location=$(xdg-open "$(zenity --file-selection --title="Select Source Location")")

# Check if user canceled the source selection
if [ $? -ne 0 ]; then
    echo "Source selection canceled."
    exit 1
fi

# Prompt user to select destination location using file manager
destination_location=$(xdg-open "$(zenity --file-selection --title="Select Destination Location")")

# Check if user canceled the destination selection
if [ $? -ne 0 ]; then
    echo "Destination selection canceled."
    exit 1
fi

# Perform the rsync
rsync -av "$source_location" "$destination_location"

echo "Rsync completed from '$source_location' to '$destination_location'."
