#!/usr/bin/env bash
#!/run/current-system/sw/bin/bash

# Tolga Erok
# 14/7/2023
# Post Nixos setup!
# ¯\_(ツ)_/¯

# -----------------------------------------------------------------------------------
# ------------- Capture the original user ID passed as an argument ------------------
# -----------------------------------------------------------------------------------

original_user_id=$1

# -----------------------------------------------------------------------------------
# -------------------- Check if Script is Run as Root -------------------------------
# -----------------------------------------------------------------------------------

if [ "$(id -u)" -ne 0 ]; then
    echo -e "${RED}[✘]${NC} This script must be run as root."
    exit 1
else
    echo -e "${GREEN}[✔]${NC}PASSED: Logged as root, continuing...\n"
    sleep 2

    # -----------------------------------------------------------------------------------
    # Install notify agents
    # -----------------------------------------------------------------------------------
    nix-env -iA nixos.libnotify
    nix-env -iA nixos.notify-desktop
    clear
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
# Create the sambashares group if it doesn't exist
# -----------------------------------------------------------------------------------

sudo groupadd -r sambashares

# -----------------------------------------------------------------------------------
# Create the usershares directory and set permissions
# -----------------------------------------------------------------------------------

sudo mkdir -p /var/lib/samba/usershares
sudo chown "$username:sambashares" /var/lib/samba/usershares
sudo chmod 1777 /var/lib/samba/usershares

# -----------------------------------------------------------------------------------
# Add the user to the sambashares group
# -----------------------------------------------------------------------------------

sudo gpasswd sambashares -a "$username"

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
# make home directory executable
# -----------------------------------------------------------------------------------

clear && echo -e "${GREEN}[✔]${NC} Almost finished\n"
cd $HOME

make-executable

# -----------------------------------------------------------------------------------
# Lets show off alittle
# -----------------------------------------------------------------------------------
my-nix && mylist && neofetch
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

# Display fortune in cowsay with Tux
fortune | cowsay -f tux
sleep 1

# Display fortune in cowsay with ^^ eyes
fortune | cowsay -e ^^
sleep 1

# Display fortune in cowsay
fortune | cowsay
sleep 1

# Display fortune in cowsay and pipe through lolcat
fortune | cowsay | lolcat
sleep 1

# -----------------------------------------------------------------------------------
# Probe system specs
# -----------------------------------------------------------------------------------

sudo -E hw-probe -all -upload

exit 1

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
