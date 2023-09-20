#!/usr/bin/env bash
#!/run/current-system/sw/bin/bash

# Tolga Erok
# 14/7/2023
# Post Nixos setup!
# ¯\_(ツ)_/¯

# -----------------------------------------------------------------------------------
# Capture the original user ID passed as an argument
# -----------------------------------------------------------------------------------

original_user_id=$1

# -----------------------------------------------------------------------------------
# Check if Script is Run as Root
# -----------------------------------------------------------------------------------

if [ "$(id -u)" -ne 0 ]; then
    echo -e "${RED}[✘]${NC} This script must be run as root."
else
    echo -e "${GREEN}[✔]${NC}PASSED: Logged as root, continuing...\n"
    sleep 2
    exit 1
fi

# -----------------------------------------------------------------------------------
# Fix nixos horrible allowance to custom packages
# -----------------------------------------------------------------------------------

export NIXPKGS_ALLOW_INSECURE=1

# -----------------------------------------------------------------------------------
# Set colour variables
# -----------------------------------------------------------------------------------

RED='\e[1;31m'
GREEN='\e[1;32m'
YELLOW='\e[1;33m'
BLUE='\e[1;34m'
CYAN='\e[1;36m'
WHITE='\e[1;37m'
ORANGE='\e[1;93m'
NC='\e[0m'

# -----------------------------------------------------------------------------------
# For fun
# -----------------------------------------------------------------------------------

start_time=$(date +%s)

# -----------------------------------------------------------------------------------
# Say hello
# -----------------------------------------------------------------------------------

espeak -v # espeak -v en-us+m7 "Thank you for using my configuration."
espeak -v # espeak -v en-us+m7 -s 165 "Welcome! To    Part    2! set  up! initiate! samba!  and   user!  Groops.     " --punct=","

# -----------------------------------------------------------------------------------
# Create user/group
# -----------------------------------------------------------------------------------

echo -e "${GREEN}[✔]${NC} Time to create smb user & group\n"
sleep 2

create-smb-user

clear

# -----------------------------------------------------------------------------------
# Pause and continue
# -----------------------------------------------------------------------------------

echo -e "${GREEN}[ 🎃 ]${NC} SMB user and Samba group added\n"
read -r -n 1 -s -t 1

clear

# -----------------------------------------------------------------------------------
# Install notify agents
# -----------------------------------------------------------------------------------

nix-env -iA nixos.libnotify
nix-env -iA nixos.notify-desktop

# -----------------------------------------------------------------------------------
# Install Samba
# -----------------------------------------------------------------------------------

nix-env -iA nixos.cifs-utils
nix-env -iA nixos.samba4Full

# -----------------------------------------------------------------------------------
# Get user id and group id
# -----------------------------------------------------------------------------------

# -----------------------------------------------------------------------------------
# Define user and group IDs here
# -----------------------------------------------------------------------------------

user_id=$(id -u "$SUDO_USER")
group_id=$(id -g "$SUDO_USER")

# -----------------------------------------------------------------------------------
# Get the user and group names using the IDs
# -----------------------------------------------------------------------------------

user_name=$(id -un "$user_id")
group_name=$(getent group "$group_id" | cut -d: -f1)

echo -e "${GREEN} ¯\_(ツ)_/¯ ${NC} User info of: ${BLUE} "$user_name" ${NC}\n"

# -----------------------------------------------------------------------------------
# Display user information
# -----------------------------------------------------------------------------------

echo -e "${GREEN}User Information${NC}"
echo -e "${BLUE}Username:${NC} $user_name"
echo -e "${BLUE}User ID:${NC} $user_id"
echo -e "${BLUE}Group Name:${NC} $group_name"
echo -e "${BLUE}Group ID:${NC} $group_id"

sleep 2

# -----------------------------------------------------------------------------------
# Function to create directories if they don't exist and set permissions
# -----------------------------------------------------------------------------------

create_directory_if_not_exist() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        echo -e "${GREEN}[✔]${NC} Created directory: $1"
        chown "$user_name":"$group_name" "$1"
        chmod 755 "$1" # Set read and execute permissions for user, group, and others
        sleep 1
        make-executable
    fi
}

# -----------------------------------------------------------------------------------
# Function to check and update permissions of existing directories
# -----------------------------------------------------------------------------------

update_directory_permissions() {
    if [ -d "$1" ]; then
        perm=$(stat -c "%a" "$1")
        if [ "$perm" != "755" ]; then
            echo -e "${GREEN}[✔]${NC} Updating permissions of existing directory: $1"
            chmod 755 "$1"
            sleep 1
            make-executable

        fi
    fi
}

# -----------------------------------------------------------------------------------
#  Create some directories and set permissions
# -----------------------------------------------------------------------------------

if [ -n "$user_name" ] && [ -n "$group_name" ]; then
    home_dir="/home/$user_name"
    config_dir="$home_dir/.config/nix"

    # -----------------------------------------------------------------------------------
    # Define function create_directory_if_not_exist and update_directory_permissions here or source them
    # -----------------------------------------------------------------------------------

    create_directory_if_not_exist "$home_dir"
    create_directory_if_not_exist "$config_dir"

    # -----------------------------------------------------------------------------------
    # Directories to create and set permissions
    # -----------------------------------------------------------------------------------

    directories=(
        "$home_dir/Documents"
        "$home_dir/Music"
        "$home_dir/Pictures"
        "$home_dir/Public"
        "$home_dir/Templates"
        "$home_dir/Videos"
    )

    for dir in "${directories[@]}"; do
        create_directory_if_not_exist "$dir"
        echo -e "${GREEN} ¯\_(ツ)_/¯ ${NC} Creating folders: /home/${BLUE}$dir${NC}\n"
        sleep 1
    done

    # -----------------------------------------------------------------------------------
    # Update directory permissions
    # -----------------------------------------------------------------------------------

    update_directory_permissions "$home_dir/Documents"
    update_directory_permissions "$home_dir/Music"
    update_directory_permissions "$home_dir/Pictures"
    update_directory_permissions "$home_dir/Public"
    update_directory_permissions "$home_dir/Templates"
    update_directory_permissions "$home_dir/Videos"

    # -----------------------------------------------------------------------------------
    # Set ownership for directories
    # -----------------------------------------------------------------------------------

    sudo chown -R "$user_name":"$group_name" "$home_dir"

    # -----------------------------------------------------------------------------------
    # Give full permissions to the nix.conf file
    # -----------------------------------------------------------------------------------

    echo "experimental-features  = nix-command flakes" | sudo -u "$user_name" tee "$config_dir/nix.conf"
    chmod 644 "$config_dir/nix.conf" # Set read permissions for user, group, and others
else
    echo -e "${RED}[✘]${NC} Failed to retrieve non-root user and group information."
    exit 1
fi

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

# -----------------------------------------------------------------------------------
#  Create some SMB user and group
# -----------------------------------------------------------------------------------

# -----------------------------------------------------------------------------------
# Function to read user input and prompt for input
# -----------------------------------------------------------------------------------

prompt_input() {
    read -p "$1" value
    echo "$value"
}

clear

# -----------------------------------------------------------------------------------
# Configure Samba Filesharing Plugin for a user
# -----------------------------------------------------------------------------------

echo -e "\nCreate and configure the Samba Filesharing Plugin..."

# -----------------------------------------------------------------------------------
# Prompt for the desired username to configure Samba Filesharing Plugin
# -----------------------------------------------------------------------------------

echo -e "${GREEN}[ 🎃 ]${NC} Enter the username to configure Samba Filesharing Plugin for:"
echo ""
echo -e "${YELLOW}┌──($(whoami)@$(hostname))-[$(pwd)]${NC}"
echo -n -e "${YELLOW}└─\$>>${NC} "
read username
echo ""

# -----------------------------------------------------------------------------------
# Set umask value
# -----------------------------------------------------------------------------------

umask 0002

# -----------------------------------------------------------------------------------
# Set permissions for the shared folder and parent directories (excluding hidden files and .cache directory)
# -----------------------------------------------------------------------------------

find "$shared_folder" -type d ! -path '/.' ! -path '/.cache' -exec chmod 0757 {} \; 2>/dev/null

# -----------------------------------------------------------------------------------
# Create the sambashares group if it doesn't exist
# -----------------------------------------------------------------------------------

sudo groupadd -r sambashares

# -----------------------------------------------------------------------------------
# Create the usershares directory and set permissions
# -----------------------------------------------------------------------------------

sudo mkdir -p /var/lib/samba/usershares
sudo chown "$username:sambashares" /var/lib/samba/usershares
sudo chmod 1770 /var/lib/samba/usershares

# -----------------------------------------------------------------------------------
# Add the user to the sambashares group
# -----------------------------------------------------------------------------------

sudo gpasswd sambashares -a "$username"

# -----------------------------------------------------------------------------------
# Set permissions for the user's home directory
# -----------------------------------------------------------------------------------

sudo chmod 0757 "/home/$username"

# -----------------------------------------------------------------------------------
# Recheck to allow insecure packages
# -----------------------------------------------------------------------------------

export NIXPKGS_ALLOW_INSECURE=1

clear

# -----------------------------------------------------------------------------------
# Rebuild system
# -----------------------------------------------------------------------------------

nixos-update
clear && echo -e "${GREEN}[✔]${NC} System updated\n"
sleep 2

# -----------------------------------------------------------------------------------
# Install wps fonts
# -----------------------------------------------------------------------------------

clear && echo -e "${GREEN}[✔]${NC} Installing custom fonts for ${BLUE} WPS${NC}\n"
sleep 1
echo -e "\n${GREEN}[✔]${NC} Downloading custom fonts for ${BLUE} WPS${NC}\n"
sudo mkdir -p ~/.local/share/fonts
wget https://github.com/tolgaerok/fonts-tolga/raw/main/WPS-FONTS.zip
unzip -o WPS-FONTS.zip -d ~/.local/share/fonts
sudo fc-cache -vf ~/.local/share/fonts
sudo fc-cache -f -v
rm WPS-FONTS.zip
rm WPS-FONTS.zip.*

# -----------------------------------------------------------------------------------
# make locations executable
# -----------------------------------------------------------------------------------
clear && echo -e "${GREEN}[✔]${NC} Almost finished\n"
cd $HOME
mse
my-nix && mylist && neofetch
sudo chown -R $(whoami):$(id -gn) /etc/nixos
sudo chmod -R 777 /etc/nixos

# -----------------------------------------------------------------------------------
# Test alittle
# -----------------------------------------------------------------------------------

wps
shotwell

# -----------------------------------------------------------------------------------
# Done
# -----------------------------------------------------------------------------------
espeak -v en+m7 -s 165 "Hewston!     we!   have!     finished!   " --punct=","
clear && echo -e "${GREEN}[✔]${NC} Setup finished\n"
clear && read -p "Press enter then control + c on next screen to exit cmatrix..."

cmatrix

clear

# -------------- Not tested use at own risk --------------#
#
# GREEN='\e[1;32m'
# nix-channel --add https://nixos.org/channels/nixos-unstable nixos
# nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
# nixos-rebuild switch --upgrade
# nix-store --gc
# clear && echo -e "${GREEN}[✔]${NC} Unstable branch and nixpkgs activated\n"
#
# -------------- Not tested use at own risk --------------#

# -----------------------------------------------------------------------------------
# Probe system specs
# -----------------------------------------------------------------------------------

sudo -E hw-probe -all -upload

exit 1
