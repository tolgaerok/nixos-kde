#!/bin/bash

# Function to display the menu
function display_menu() {
    echo "Select an option:"
    echo "1) SSH to Windows 11"
    echo "2) SSH to Ubuntu Server"
    echo "3) SSH to NixOs"
    echo "4) SSH to Toshiba Laptop"
    echo "5) SSH to ThinClient"
    echo "6) Quit"
}

# Function to handle invalid input
function invalid_input() {
    echo "Invalid input. Please choose a valid option."
}

# Main loop
while true; do
    display_menu
    read -p "Enter your choice: " choice

    case $choice in
        1)
            ssh tolga@192.168.0.20
            ;;
        2)
            ssh tolga@192.168.0.11
            ;;
        3)
            ssh tolga@192.168.0.13
            ;;
        4)
            ssh tolga@192.168.0.3
            ;;
        5)
            ssh tolga@192.168.0.8
            ;;
        6)
            echo "Quitting the script."
            break
            ;;
        *)
            invalid_input
            ;;
    esac
done
