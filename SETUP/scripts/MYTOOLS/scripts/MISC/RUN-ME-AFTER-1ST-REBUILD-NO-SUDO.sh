#!/usr/bin/env bash
set -x

RED='\e[1;31m'
GREEN='\e[1;32m'
YELLOW='\e[1;33m'
BLUE='\e[1;34m'
CYAN='\e[1;36m'
WHITE='\e[1;37m'
ORANGE='\e[1;93m'
NC='\e[0m'

if [ "$(id -u)" -eq 0 ]; then
  echo -e "\n${RED}[✘]${NC} ${YELLOW} ERROR! ${NC} $(basename "$0") should be run as a ${GREEN}regular${NC} user\n"
  exit 1
fi

# -----------------------------------------------------------------------------------
# Install some  agents
# -----------------------------------------------------------------------------------

start_time=$(date +%s)
current_dir=$(pwd)
clear

# -----------------------------------------------------------------------------------
# First etc/nixos backup
# -----------------------------------------------------------------------------------
nixos-archive
# -----------------------------------------------------------------------------------

# -----------------------------------------------------------------------------------
# He's ALIVE!!
# -----------------------------------------------------------------------------------
espeak -v en+m7 -s 165 "Welcome! This script will! initiate! the! basic! setup! for your system. Thank you for using! my configuration." --punct=","
espeak -v en+m7 -s 165 "Copying!   fonts!    wallpapers!   and    creating!  the!   basic!   setup! for   your     system. " --punct=","

# -----------------------------------------------------------------------------------
# Flatpak section
# -----------------------------------------------------------------------------------

echo -e "${GREEN}[✔]${NC} Install Flatpak apps..\n"

# -----------------------------------------------------------------------------------
# Enable Flatpak
# -----------------------------------------------------------------------------------

if ! flatpak remote-list | grep -q "flathub"; then
  sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
else
  echo -e "${GREEN}[✔]${NC} Flatpak enabled...\n"
  sleep 2
fi

# -----------------------------------------------------------------------------------
# Update Flatpak
# -----------------------------------------------------------------------------------

echo -e "${GREEN}[✔]${NC} Updating cache, this will take a while..\n"
sudo flatpak update -y

# -----------------------------------------------------------------------------------
# Install Flatpak apps
# -----------------------------------------------------------------------------------

packages=(
  com.sindresorhus.Caprine
  org.kde.kweather
)

# -----------------------------------------------------------------------------------
# Install each package if not already installed
# -----------------------------------------------------------------------------------

for package in "${packages[@]}"; do
  if ! flatpak list | grep -q "$package"; then
    echo "Installing $package..."
    sudo flatpak install -y flathub "$package"
  else
    echo "$package is already installed. Skipping..."
  fi
done

# -----------------------------------------------------------------------------------
# List all flatpak
# -----------------------------------------------------------------------------------

echo -e "${GREEN}[✔]${NC} Show Flatpak info:"
su - "$USER" -c "flatpak remote-list"
echo ""

echo -e "
\033[33mChecking all runtimes installed: \033[0m
"
flatpak list --runtime
echo ""

echo -e "${GREEN}[✔]${NC}
List of flatpak's installed on system:
"
flatpak list --app
echo ""

# Paths
font_folder="/etc/nixos/SETUP/fonts"
font_dest="/home/$(whoami)/.local/share/fonts"

script_folder="/etc/nixos/SETUP/scripts"
script_dest="/home/$(whoami)"

wallpapers_src="/etc/nixos/SETUP/wallpapers"
wallpapers_dest="/home/$(whoami)/Pictures"

# Create destination folders if they don't exist

# Check if font_dest exists
if [ -d "$font_dest" ]; then

  # Copy contents of font_folder into font_dest
  cp -r "$font_folder"/* "$font_dest/"
  echo "Contents of $font_folder copied to $font_dest"
  notify-send --icon=font-collection --app-name="DONE" "Fonts folder copied into $(whoami)" "$font_dest" -u normal
else
  echo "$font_dest does not exist. Creating it..."
  mkdir -p "$font_dest"
  cp -r "$font_folder"/* "$font_dest/"
  echo "Contents of $font_folder copied to $font_dest"
fi

mkdir -p "$script_dest"
mkdir -p "$wallpapers_dest"

# Move the scripts folder and its contents
cp -r "$script_folder" "$script_dest"
notify-send --icon=text-x-script --app-name="DONE" "Script folder copied into $(whoami)" "$script_dest" -u normal

# Move the wallpapers folder and its contents
cp -r "$wallpapers_src" "$wallpapers_dest"
notify-send --icon=litedesktop --app-name="DONE" "Wallpaper folder moved into $(whoami)" "$wallpapers_dest" -u normal

# Set permissions for the destination folders and their contents
chmod -R u+rw "$font_dest"
chmod -R u+rw "$script_dest"
chmod -R u+rw "$wallpapers_dest"

# Get user and group of the current user
user_name=$(whoami)
user_group=$(id -gn "$user_name")

# Set ownership to the user and user's group
chown -R "$user_name":"$user_group" "$font_dest"
chown -R "$user_name":"$user_group" "$script_dest"
chown -R "$user_name":"$user_group" "$wallpapers_dest"

sleep 2

# Change Wallpaper
clear

echo "Setting up Desktop wallpaper"

# Get the script's folder path
script_folder="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Specify the source image file path
source_file="/etc/nixos/SETUP/wallpapers/arc-mountain.png"
#source_file="/etc/nixos/SETUP/wallpapers/nix.png"

# Specify the destination picture folder path
picture_folder="$HOME/Pictures"

# Specify the destination wallpaper file name
wallpaper_file="wallpaper.jpg"

# Check if the source image file exists
if [ ! -f "$source_file" ]; then
  echo "Error: Source image file not found."
  sleep 2
fi

# Copy the image file to the picture folder
cp "$source_file" "$picture_folder/$wallpaper_file"
if [ $? -ne 0 ]; then
  echo "Failed to copy the image file to the picture folder."
  sleep 2
fi

# Set the wallpaper using KDE's command-line tool
command="qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript"
script="
var allDesktops = desktops();
for (i=0;i<allDesktops.length;i++) {
    d = allDesktops[i];
    d.wallpaperPlugin = 'org.kde.image';
    d.currentConfigGroup = Array('Wallpaper', 'org.kde.image', 'General');
    d.writeConfig('Image', 'file://$picture_folder/$wallpaper_file');
    d.writeConfig('FillMode', '2');
}"
eval "$command \"$script\""

echo "Desktop Wallpaper set successfully."
sleep1
clear

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

echo "Directories and configuration files created successfully."

espeak -v en-us+m7 -s 165 "Scripts! fonts! and! wallpapers! have been! moved! to your home! directory! and permissions set!"
echo "Scripts, fonts and wallpapers folders have been moved to your home directory and permissions set."

end_time=$(date +%s)
time_taken=$((end_time - start_time))

notify-send --icon=ktimetracker --app-name="Post set-up" "Basic set-up Complete" "Time taken: $time_taken seconds" -u normal

# -----------------------------------------------------------------------------------
# Make scripts and nix files executable in varioud directories
# -----------------------------------------------------------------------------------
make-executable
cd $HOME && make-executable
cd /etc/nixos/ && make-executable
cd /etc/nixos/SETUP && make-executable

# -----------------------------------------------------------------------------------
# Check if the 59-minute cron job already exists in the crontab, if not add
# ability to backup /etc/nixos every 59 mins
# -----------------------------------------------------------------------------------
if ! crontab -l | grep -q "*/59 * * * * nixos-archive >> /home/tolga/test.log"; then
  # Add the 59-minute cron job to the crontab
  echo "*/59 * * * * nixos-archive >> /home/tolga/test.log" | crontab -
  echo "Cron job added successfully to run every 59 minutes."
else
  echo "Cron job already set to run every 59 minutes in the crontab."
fi

notify-send --icon=gtk-help --app-name="Cron setup" "Cron job added" "Time taken: $time_taken seconds" -u normal

# Get the current user and their primary group
current_user=$(whoami)
current_user_group=$(id -gn)

echo "Current user: $current_user" && sleep 1
echo "Current user's primary group: $current_user_group" && sleep 1

sudo ./PART-B-WITH-SUDO.sh $(id -u)

# Return to the original directory
cd "$current_dir"
