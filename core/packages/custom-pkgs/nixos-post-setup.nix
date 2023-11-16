{ config, pkgs, lib, ... }:

let

  nixos-post-setup = pkgs.writeScriptBin "nixos-post-setup" ''
    #!/usr/bin/env bash

    # Personal nixos post setup
    # Tolga Erok. ¯\_(ツ)_/¯
    # 9/9/2023

    # set -x

    # -----------------------------------------------------------------------------------
    # Install some  agents
    # -----------------------------------------------------------------------------------
    start_time=$(date +%s)
    current_dir=$(pwd)
    clear

    # -----------------------------------------------------------------------------------
    # First etc/nixos backup
    # 
    nixos-archive

    # -----------------------------------------------------------------------------------
    # He's ALIVE!!
    # 
    espeak -v en+m7 -s 165 "Welcome! This script will! initiate! the! basic! setup! for your system. Thank you for using! my configuration." --punct=","
    espeak -v en+m7 -s 165 "Copying!   fonts!    wallpapers!   and    creating!  the!   basic!   setup! for   your     system. " --punct=","

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
    sleep 2
    notify-send --icon=litedesktop --app-name="DONE" "$(whoami) home folders created" " in $HOME" -u normal
    sleep 2

    clear
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

    # -----------------------------------------------------------------------------------
    # ------------- Capture the original user ID passed as an argument ------------------
    # -----------------------------------------------------------------------------------

    original_user_id=$1

    echo -e "[✘] This section must be run as root..."
    sleep 1

    sudo nix-env -iA nixos.libnotify
    sudo nix-env -iA nixos.notify-desktop

    # -----------------------------------------------------------------------------------
    # Flatpak section
    # -----------------------------------------------------------------------------------
    echo -e "[✔] Install Flatpak apps..\n"

    # -----------------------------------------------------------------------------------
    # Enable Flatpak
    # -----------------------------------------------------------------------------------
    if ! flatpak remote-list | grep -q "flathub"; then
      sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    else
      echo -e "[✔] Flatpak enabled...\n"
      sleep 2
    fi

    # -----------------------------------------------------------------------------------
    # Update Flatpak
    # -----------------------------------------------------------------------------------
    echo -e "[✔] Updating cache, this will take a while..\n"
    sudo flatpak update -y

    # -----------------------------------------------------------------------------------
    # Install Flatpak apps
    # -----------------------------------------------------------------------------------
    flatpak install -y flathub com.anydesk.Anydesk
    flatpak install -y flathub com.sindresorhus.Caprine
    flatpak install -y flathub io.github.mimbrero.WhatsAppDesktop
    flatpak install -y flathub org.fedoraproject.MediaWriter
    flatpak install -y flathub org.kde.kweather

    # -----------------------------------------------------------------------------------
    # List all flatpak
    # -----------------------------------------------------------------------------------
    echo -e "[✔] Show Flatpak info:"
    su - "$USER" -c "flatpak remote-list"
    echo ""

    echo -e "
    \033[33mChecking all runtimes installed: \033[0m
    "
    flatpak list --runtime
    echo ""

    echo -e "[✔]
    List of flatpak's installed on system:
    "
    flatpak list --app
    echo ""

    # -----------------------------------------------------------------------------------
    # Fix nixos horrible allowance to custom packages
    # -----------------------------------------------------------------------------------
    export NIXPKGS_ALLOW_INSECURE=1

    # -----------------------------------------------------------------------------------
    # For fun
    # -----------------------------------------------------------------------------------
    start_time=$(date +%s)

    # -----------------------------------------------------------------------------------
    # Say hello
    # -----------------------------------------------------------------------------------
    espeak -v espeak -v en-us+m7 "Thank you for using my configuration."
    espeak -v espeak -v en-us+m7 -s 165 "Welcome! To    Part    2! set  up! initiate! samba!  and   user!  Groops.     " --punct=","

    # -----------------------------------------------------------------------------------
    # Create user/group
    # -----------------------------------------------------------------------------------
    echo -e "[✔] Time to create smb user & group\n"
    sleep 2

    create-smb-user

    clear

    # -----------------------------------------------------------------------------------
    # Pause and continue
    # -----------------------------------------------------------------------------------
    echo -e "[ 🎃 ] SMB user and Samba group added\n"
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

    echo -e " ¯\_(ツ)_/¯  User info of: "$user_name" \n"

    # -----------------------------------------------------------------------------------
    # Display user information
    # -----------------------------------------------------------------------------------
    echo -e "User Information"
    echo -e "Username: $user_name"
    echo -e "User ID: $user_id"
    echo -e "Group Name: $group_name"
    echo -e "Group ID: $group_id"

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
    # echo -e "\nCreate and configure the Samba Filesharing Plugin..."

    # -----------------------------------------------------------------------------------
    # Prompt for the desired username to configure Samba Filesharing Plugin
    # -----------------------------------------------------------------------------------
    # echo -e "[ 🎃 ] Enter the username to configure Samba Filesharing Plugin for:"
    # echo ""
    # echo -e "┌──($(whoami)@$(hostname))-[$(pwd)]"
    # echo -n -e "└─\$>> "
    # read username
    # echo ""

    # -----------------------------------------------------------------------------------
    # Create the sambashares group if it doesn't exist
    # -----------------------------------------------------------------------------------
    sudo groupadd -r sambashares

    # -----------------------------------------------------------------------------------
    # Create the shares folder
    # -----------------------------------------------------------------------------------
    sudo mkdir -p /home/NixOs
    sudo chmod 777 /home/NixOs

    # -----------------------------------------------------------------------------------
    # Create the usershares directory and set permissions
    # -----------------------------------------------------------------------------------
    # sudo mkdir -p /var/lib/samba/usershares
    # sudo chown "$username:sambashares" /var/lib/samba/usershares
    # sudo chmod 1777 /var/lib/samba/usershares

    # -----------------------------------------------------------------------------------
    # Add the user to the sambashares group
    # -----------------------------------------------------------------------------------
    # sudo gpasswd sambashares -a "$username"

    # -----------------------------------------------------------------------------------
    # Recheck to allow insecure packages
    # -----------------------------------------------------------------------------------
    export NIXPKGS_ALLOW_INSECURE=1

    clear

    # -----------------------------------------------------------------------------------
    # Rebuild system
    # -----------------------------------------------------------------------------------
    nixos-update
    clear && echo -e "[✔] System updated\n"
    sleep 2

    # -----------------------------------------------------------------------------------
    # Install wps fonts
    # -----------------------------------------------------------------------------------
    clear && echo -e "[✔] Installing custom fonts for  WPS\n"
    sleep 1

    echo -e "\n[✔] Downloading custom fonts for  WPS\n"

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
    clear && echo -e "[✔] Almost finished\n"
    cd $HOME

    make-executable

    # -----------------------------------------------------------------------------------
    # Lets show off alittle
    # -----------------------------------------------------------------------------------
    my-nix && mylist && neofetch
    wps

    # -----------------------------------------------------------------------------------
    # Done
    # -----------------------------------------------------------------------------------
    espeak -v en+m7 -s 165 "Hewston!     we!   have!     finished!   " --punct=","
    clear && echo -e "[✔] Setup finished\n"
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

    # Return to the original directory
    cd "$current_dir"

    exit 1

  '';

in {

  #---------------------------------------------------------------------
  # Type: xxx in terminal to execute above bash script
  #---------------------------------------------------------------------

  environment.systemPackages = [ nixos-post-setup ];
}
