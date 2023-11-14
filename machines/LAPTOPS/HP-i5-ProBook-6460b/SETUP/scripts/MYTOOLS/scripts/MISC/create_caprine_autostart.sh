#!/usr/bin/env bash

# Personal caprine auto starter
# Tolga Erok. ¯\_(ツ)_/¯
# 2/9/23

GREEN='\e[1;32m'
clear

# Create the autostart directory if it doesn't exist
autostart_dir="$HOME/.config/autostart"
mkdir -p "$autostart_dir"

# Create the desktop file for Caprine
desktop_file="$autostart_dir/caprine.desktop"
cat <<EOL >"$desktop_file"
[Desktop Entry]
Type=Application
Name=Caprine
Exec=flatpak run com.sindresorhus.Caprine
X-GNOME-Autostart-enabled=true
EOL

# Make the desktop file executable
chmod +x "$desktop_file"

echo -e "${GREEN}[✔]${NC} Caprine autostart configuration completed.\n"
