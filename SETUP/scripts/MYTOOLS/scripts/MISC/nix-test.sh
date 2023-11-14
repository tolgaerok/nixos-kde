#!/usr/bin/env nix-shell
#! nix-shell -i bash -p bash

# Create directories a, b, and c in the user's home directory
mkdir ~/a ~/b ~/c

# Directory paths
directories=(~/Desktop ~/Documents ~/Downloads ~/Pictures ~/Music ~/Videos ~/Public ~/Templates)
hidden_directories=(~/.config ~/.ssh)
config_files=(~/.bash_profile ~/.bashrc ~/.profile)

# Create directories
for dir in "${directories[@]}"; do
  mkdir -p "$dir"
done

# Create hidden directories
for dir in "${hidden_directories[@]}"; do
  mkdir -p "$dir"
done

# Create config files
for file in "${config_files[@]}"; do
  touch "$file"
done

# Echo success message
echo "Directories and configuration files created successfully in $HOME (MIDDLE SCRIPT)"

# Create directories in the user's home directory

mkdir -p ~/Desktop
mkdir -p ~/Documents
mkdir -p ~/Downloads
mkdir -p ~/Pictures
mkdir -p ~/Music
mkdir -p ~/Videos
mkdir -p ~/Public
mkdir -p ~/Templates

# Optional: Create hidden directories and files
mkdir -p ~/.config
mkdir -p ~/.ssh

# Optional: Create user-specific configuration files
touch ~/.bash_profile
touch ~/.bashrc
touch ~/.profile

echo "Directories and configuration files created successfully in user: $HOME (END SCRIPT)."

curl -sSL -o /tmp/deb-logo.png https://github.com/tolgaerok/Debian-tolga/raw/main/WALLPAPERS/deb-logo.png

# Resize the image to 101x85
convert /tmp/deb-logo.png -resize 101x98 /tmp/deb-logo-resized.png

# Display the Debian ASCII art logo as the background
jp2a --background=light --colors --width="$(tput cols)" /tmp/deb-logo-resized.png
