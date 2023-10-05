#!/bin/bash
# Tolga Erok 6/7/2023
# Personal script that retrieves the current working directory, searches for files with the ".sh" extension
# within that directory, and makes those files executable within the (PWD)

# Get the current working directory
folder="$(pwd)"

# Find all files ending with the .sh extension inside the folder
# find "$folder" -type f -name "*.sh" -exec chmod u+x {} \; -exec bash -c 'echo -e "\e[34mFolder: \e[97m'"$folder"'\e[0m\n\e[33mScript: \e[94m{} \e[0m\n\e[32mNow executable.\e[0m"' \;
find "$folder" -type f \( -name "*.sh" -o -name "*.nix" \) -exec chmod u+x {} \; -exec bash -c 'echo -e "\e[34mFolder: \e[97m'"$folder"'\e[0m\n\e[33mScript: \e[94m{} \e[0m\n\e[32mNow executable.\e[0m"' \;

