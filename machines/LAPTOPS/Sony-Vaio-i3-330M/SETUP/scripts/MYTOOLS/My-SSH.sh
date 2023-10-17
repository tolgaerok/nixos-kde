#!/usr/bin/env bash

# Personal SSH script.
# Tolga Erok. ¯\_(ツ)_/¯
# 2/9/23

set -e

clear

RED='\e[1;31m'
GREEN='\e[1;32m'
YELLOW='\e[1;33m'
BLUE='\e[1;34m'
CYAN='\e[1;36m'
WHITE='\e[1;37m'
ORANGE='\e[1;93m'
NC='\e[0m'

# Help text
help_text="Personal script (beta)

Usage: ./script.sh [OPTIONS]

Options:
--help              Show this help message
--ubuntuserver      SSH to Ubuntu Server


"

COLOR_NUM=$((RANDOM % 7))

# Assign a color variable based on the RANDOM number
case $COLOR_NUM in
    0) COLOR=$RED;;
    1) COLOR=$GREEN;;
    2) COLOR=$YELLOW;;
    3) COLOR=$BLUE;;
    4) COLOR=$CYAN;;
    5) COLOR=$ORANGE;;
    *) COLOR=$WHITE;;

esac

# Function to check port 22
function check_port22() {
    if pgrep sshd > /dev/null; then
        echo -e "${GREEN}[✔]${NC} SSH service is running on port 22\n"
    else
        echo -e "${RED}[✘]${NC} SSH service is not running on port 22. Install and enable SSHD service.\n"
    fi
}


# Function to display the menu
function display_menu() {
    echo -e "${BLUE}Select an option:${NC}"
    echo -e "--------------------------------\n"
    echo "1) SSH to Windows 11"
    echo -e "2) SSH to ${ORANGE}Ubuntu${NC} Server"
    echo -e "3) SSH to ${BLUE}NixOs${NC}"
    echo -e "4) SSH to ${CYAN}Toshiba${NC} Laptop"
    echo -e "5) SSH to ThinClient ${GREEN}Mint21${NC}"
    echo -e "6) ${WHITE}MariaDB on ${ORANGE}Ubuntu${NC} Server  ${NC}"

    echo -e "\n--------------------------------"
    echo -e "0)${RED} Quit\n ${NC}"
}

# Function to handle invalid input
function invalid_input() {
    echo -e "${RED}[✘]${NC} Invalid input. Please choose a valid option."
    sleep 1
    clear
}

# Function to execute an SSH command and retry if it fails
function ssh_command_retry() {
    local host=$1
    local command=$2
    local retries=2
    local delay=0

    for ((i = 1; i <= retries; i++)); do
        ssh -q "tolga@$host" "$command" && {
            echo -e "${GREEN}[✔]${NC} Connected to $host successfully"
            return 0
        }
        echo -e "${RED}[✘]${NC} Failed to connect to $host. Retrying..."
        sleep "$delay"
    done

    echo -e "${RED}[✘]${NC} Unable to execute SSH command: $command\n"
    sleep 2
}

check_internet_connection() {
    echo -e "${YELLOW}[*]${NC} Checking Internet Connection .."
    echo ""

    if curl -s -m 10 https://www.google.com > /dev/null || curl -s -m 10 https://www.github.com > /dev/null; then
        echo -e "${GREEN}[✔]${NC} Network connection is OK ${GREEN}[✔]${NC}"
    else
        echo -e "${RED}[✘]${NC} Network connection is not available ${RED}[✘]${NC}"
    fi

    echo ""
    sleep 1
    echo -e "${YELLOW}[*]${NC} Executing menu ..."
    sleep 2
    clear
}

# Function to display help text
function show_help() {
  echo -e "$help_text"
}

# Call the function to check internet connection
check_internet_connection

# Function to handle command-line options
function handle_options() {
    case "$1" in
        --help)
            show_help
            exit 0
        ;;
        --checkport)
            check_port22
            exit 0
        ;;
        --ubuntuserver)
            check_port22
            ssh_command_retry "192.168.0.11" ""
            # exit 0
        ;;
        *)
        ;;
    esac
}

# Call the function to handle command-line options
handle_options "$1"

# Main loop
while true; do
    display_menu
    echo -e "${YELLOW}┌──($USER㉿$HOST)-[$(pwd)]${NC}"

    choice=""
    echo -n -e "${YELLOW}└─\$>>${NC} "
    read choice

    echo ""
    clear

    case $choice in
        1)
            check_port22
            ssh_command_retry "192.168.0.20" ""
        ;;
        2)
            check_port22
            ssh_command_retry "192.168.0.11" ""
        ;;
        3)
            check_port22
            ssh_command_retry "192.168.0.13" ""
        ;;
        4)
            check_port22
            ssh_command_retry "192.168.0.5" ""
        ;;
        5)
            check_port22
            ssh_command_retry "192.168.0.8" ""
        ;;
        6)
            mysql -h 192.168.0.11 -P 3306 -u tolga -p
        ;;
        0)
            echo -e "${RED}[✘]${NC} Quitting the script.${NC}"
            break
        ;;
        *)
            invalid_input
        ;;
    esac
done
