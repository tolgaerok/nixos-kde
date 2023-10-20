#!/bin/bash

# Check if dialog is installed, if not install
if ! command -v dialog &> /dev/null; then
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        if [ "$ID" == "fedora" ]; then
            sudo dnf install -y dialog
        elif [ "$ID" == "ubuntu" ]; then
            sudo apt update && sudo apt install -y dialog
        fi
    fi
fi

# Check if script is running as root, if not, prompt for root password
if [ "$(id -u)" -ne 0 ]; then
    PASSWORD=$(dialog --stdout --title "Root Password" --passwordbox "Enter your root password:" 0 0)
    if [ "$?" -ne 0 ]; then
        exit 1
    fi
    echo "$PASSWORD" | sudo -S "$0" "$@"
    exit $?
fi

# Define function to execute commands and update progress bar
execute_commands() {
    echo 0 | dialog --title "Progress" --gauge "Executing commands..." 7 70 0
    sudo apt list network-manager -a
    echo 10 | dialog --title "Progress" --gauge "Executing commands..." 7 70 10
    sudo apt list systemd-resolved -a
    echo 20 | dialog --title "Progress" --gauge "Executing commands...flush dev wlx08606eca6941" 7 70 20
    sudo ip addr flush dev wlx08606eca6941
    echo 30 | dialog --title "Progress" --gauge "Executing commands...stop NetworkManager.service" 7 70 30
    sudo systemctl stop NetworkManager.service
    echo 40 | dialog --title "Progress" --gauge "Executing commands...start NetworkManager.service" 7 70 40
    sudo systemctl start NetworkManager.service
    echo 50 | dialog --title "Progress" --gauge "Executing commands...systemd-resolve --flush-caches" 7 70 50
    sudo systemd-resolve --flush-caches
    echo 70 | dialog --title "Progress" --gauge "Executing commands...daemon-reload" 7 70 70
    sudo systemctl daemon-reload
    echo 70 | dialog --title "Progress" --gauge "Executing commands...systemctl start smb nmb" 7 70 78
    sudo systemctl enable smb nmb && sudo systemctl start smb nmb
    echo 80 | dialog --title "Progress" --gauge "Executing commands...mount -a" 7 70 88
    sudo mount -a
    clear
    echo 80 | dialog --title "Progress" --gauge "Executing commands...mount -t nfs,smbfs,cifs" 7 70 93
    sudo systemctl daemon-reload
    sudo systemctl enable mnt-linux-data.automount
    clear
    sudo mount -a
    sudo mount -t nfs,smbfs,cifs
    sudo systemctl restart autofs
    clear
    sudo ls -l /mnt/linux-data
    sudo mount -a
    clear
    echo 100 | dialog --title "Progress" --gauge "Executing commands...clear" 7 70 100
    clear

    sleep 1
}

# Prompt user for password and execute commands
while true; do
    PASSWORD=$(dialog --stdout --title "Password" --passwordbox "Enter your password:" 0 0)
    if [ "$?" -ne 0 ]; then
        exit 1
    fi
    echo "$PASSWORD" | sudo -S echo "Password accepted"
    if [ "$?" -eq 0 ]; then
        execute_commands
        break
    else
        dialog --title "Error" --msgbox "Incorrect password. Please try again." 0 0
    fi
done

# Display done message and wait for user input
clear
dialog --title "Done" --msgbox "Done executing commands. Press any key to exit." 0 0

# Determine which terminal emulator to use
if command -v xterm &> /dev/null; then
    # Use xterm to display the "Press any key to exit" message and hold the terminal open
    xterm -hold -e "echo 'Press any key to exit'; read -n1" &
else
    # Use the default terminal to display the "Press any key to exit" message and hold the terminal open
    echo "Press any key to exit"
    read -n1
fi

# Close the current terminal window
exit
# Close the current terminal window
exit


