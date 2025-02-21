#!/bin/bash

# Get the current working directory
folder="$(pwd)"

# Find all files ending with the .sh extension inside the folder
find "$folder" -type f -name "*.sh" -exec bash -c 'echo -e "\e[34mFolder: \e[97m'"$folder"'\e[0m\n\e[33mScript: \e[94m{} \e[0m\n\e[32mNow executable.\n\e[0m"' \;
