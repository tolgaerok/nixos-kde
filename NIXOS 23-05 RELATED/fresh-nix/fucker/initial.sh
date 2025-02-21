#!/bin/bash

# Find the sudo user and group
sudo_user=$(logname)
sudo_group=$(id -gn "$sudo_user")

# Set ownership and permissions for user's home directory
sudo chown -R "$sudo_user:$sudo_group" "/home/$sudo_user"
sudo chmod 755 "/home/$sudo_user"

# Create necessary directories with appropriate permissions
directories=(
    "/home/$sudo_user/.mozilla"
    "/home/$sudo_user/.config"
    "/home/$sudo_user/.fonts"
    "/home/$sudo_user/.gnupg"
    "/home/$sudo_user/.local/bin"
    "/home/$sudo_user/.ssh"
    "/home/$sudo_user/.themes"
    "/home/$sudo_user/Documents"
    "/home/$sudo_user/Downloads"
    "/home/$sudo_user/Music"
    "/home/$sudo_user/Pictures"
    "/home/$sudo_user/Videos"
)

for dir in "${directories[@]}"; do
    sudo mkdir -p "$dir"
    sudo chown "$sudo_user:$sudo_group" "$dir"
    sudo chmod 755 "$dir"
done

# Create empty files with appropriate permissions
files=(
    "/home/$sudo_user/.Xresources"
    "/home/$sudo_user/.bash_aliases"
    "/home/$sudo_user/.bash_profile"
    "/home/$sudo_user/.bashrc"
    "/home/$sudo_user/.gitconfig"
    "/home/$sudo_user/.inputrc"
    "/home/$sudo_user/.profile"
    "/home/$sudo_user/.vimrc"
    "/home/$sudo_user/.xinitrc"
    "/home/$sudo_user/.xsession"
    "/home/$sudo_user/.netrc"
    "/home/$sudo_user/.zshrc"
    
)

for file in "${files[@]}"; do
    sudo touch "$file"
    sudo chown "$sudo_user:$sudo_group" "$file"
    sudo chmod 644 "$file"
done


