#!/usr/bin/env bash
# Use more POSIX shebang principles

# Tolga Erok  20/6/2023
# Copy contents of wallpapers and fonts folder in scripts CWD into current Nixos users profile
# Then nstall fonts

current_user="$SUDO_USER"
current_user_home="/home/$current_user"
pictures_dir="$current_user_home/Pictures"

# Check for pictures folder and create if it dosnt exist
mkdir -p "$pictures_dir/CustomWallpapers"
cp -r "$(dirname "$(readlink -f "$0")")/WALLPAPERS"/* "$pictures_dir/CustomWallpapers"

# chown of current user to the newly created folder
if [ -d "$pictures_dir" ]; then
  chown -R --reference="$pictures_dir" "$pictures_dir/CustomWallpapers"
fi

# Install fonts
fontsDir="$current_user_home/.local/share/fonts"
mkdir -p "$fontsDir"
cp "$(dirname "$(readlink -f "$0")")/FONTS/"* "$fontsDir"
chown -R "$current_user" "$fontsDir"
fc-cache -f "$fontsDir"

# Update font cache
echo "Updating font cache..."
fc-cache -f "$fontsDir"
