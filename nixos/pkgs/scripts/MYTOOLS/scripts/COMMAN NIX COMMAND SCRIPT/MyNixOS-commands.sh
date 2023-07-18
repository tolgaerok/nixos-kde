#!/usr/bin/env bash
#!/run/current-system/sw/bin/bash

# Tolga Erok    10/6/2023   Basic script that allows user to run common Nix commands at sudo level.
# Change log: corrected nix commands in menu, syntax error in delete old gens: -p option was not properly enclosed in quote
# Change log: add #!/bin/env bash to follow POIX standards

# Function to execute a command in sudo mode
execute_command() {
    echo -e "\033[1;33mExecuting command: sudo $1\033[0m"
    sudo $1
}

# Function to display the menu options
display_menu() {
    echo -e "\033[1;34mNix Useful Commands Menu:\033[0m"
    echo -e "\033[1;32m 1.   nixos-rebuild switch\033[0m                    Rebuild and switch to the NixOS configuration"
    echo -e "\033[1;32m 2.   nix-store --optimise\033[0m                    Optimize the Nix store"
    echo -e "\033[1;32m 3.   nix-collect-garbage\033[0m                     Collect garbage from the Nix store"
    echo -e "\033[1;32m 4.   nix-store --gc\033[0m                          Perform garbage collection"
    echo -e "\033[1;32m 5.   nix-env --list-generations\033[0m              List generations of the active profile"
    echo -e "\033[1;32m 6.   nix-env --profile --list-generations\033[0m    List generations of the system profile"
    echo -e "\033[1;32m 7.   nix-channel --list\033[0m                      List available channels"
    echo -e "\033[1;32m 8.   List unstable channels\033[0m                  List available unstable channels"
    echo -e "\033[1;32m 9.   Add unstable channel\033[0m                    Add the unstable channel"
    echo -e "\033[1;32m10.   Delete unstable channel\033[0m                 Delete the unstable channel"
    echo -e "\033[1;32m11.   Refresh channels\033[0m                        Refresh all channels"
    echo -e "\033[1;32m12.   Upgrade packages\033[0m                        Upgrade all installed packages"
    echo -e "\033[1;32m13.   Upgrade channels\033[0m                        Upgrade all channels"
    echo -e "\033[1;32m14.   nix-store optimise\033[0m                      Optimize the Nix store (alternative command)"
    echo -e "\033[1;32m15.   nix-store --optimise --all\033[0m              Optimize the Nix store (alternative command)"
    echo -e "\033[1;32m16.   nix-store --gc --print-dead\033[0m             Print the paths to be deleted during garbage collection"
    echo -e "\033[1;32m17.   Delete old generations\033[0m                   Delete old generations of the active profile"
    echo -e "\033[1;32m 0.   Exit\033[0m                                    Exit the script"
}

# Function to delete old generations
delete_old_generations() {
    echo -e "\033[1;34mDelete Old Generations Menu:\033[0m"
    echo -e "\033[1;32mGeneration   Age\033[0m"

    # Get the list of generations
    generations=$(sudo nix-env --profile /nix/var/nix/profiles/system --list-generations | tail -n +3)

    # Sort generations from oldest to newest
    sorted_generations=$(echo "$generations" | sort -n)

    # Calculate age for each generation and display
    while read -r generation; do
        age=$(sudo nix-env --query --requisites --installed --profile /nix/var/nix/profiles/system/$generation | awk -F ":" '{print $2}')
        printf "%-13s %s\n" "$generation" "$age"
    done <<< "$sorted_generations"

    # Prompt for generation to delete
    read -p $'\n\033[1;33mEnter the generation to delete (0 to cancel): \033[0m' choice
    if [[ "$choice" -gt 0 ]]; then
        execute_command "sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations $choice"
    fi
}

# Clear the screen on the first run
clear

# Display the initial menu
display_menu

# Loop until the user selects "Exit"
while true; do
    read -p "Enter your choice (0-17): " choice
    case $choice in
        1) execute_command "nixos-rebuild switch" ;;
        2) execute_command "nix-store --optimise" ;;
        3) execute_command "nix-collect-garbage -d" ;;
        4) execute_command "nix-store --gc" ;;
        5) execute_command "nix-env --list-generations" ;;
        6) execute_command "nix-env --profile /nix/var/nix/profiles/system --list-generations" ;;
        7) execute_command "nix-channel --list" ;;
        8) execute_command "nix-channel --list --unstable" ;;
        9) execute_command "nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable" ;;
        10) execute_command "nix-channel --remove nixos-unstable" ;;
        11) execute_command "nix-channel --update" ;;
        12) execute_command "nix-env --upgrade" ;;
        13) execute_command "nix-channel --update" ;;
        14) execute_command "nix-store --optimise" ;;
        15) execute_command "nix-collect-garbage" ;;
        16) execute_command "nix-store --gc --print-dead" ;;
        17) execute_command "sudo nix-collect-garbage --delete-old" ;;
        0) exit ;;
        *) echo -e "\033[1;31mInvalid choice. Please try again.\033[0m" ;;
    esac
    read -rsn1 -p "Press any key to continue..."
    clear
    display_menu
done
