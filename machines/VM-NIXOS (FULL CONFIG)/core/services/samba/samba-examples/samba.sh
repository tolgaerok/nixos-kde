#!/usr/bin/env bash

# Define color and formatting codes
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
RESET='\033[0m'

# Check if 'tolga' is already in the 'samba' group
if getent group samba | grep -q tolga; then
    echo -e "${BOLD}${BLUE}User '${YELLOW}tolga${RESET}${BLUE}' is already in the '${YELLOW}samba${RESET}${BLUE}' group. Exiting.${RESET}"
    exit 0
fi

# Continue with further script execution if 'tolga' is not in the 'samba' group
# Add the user 'tolga' to the 'samba' group
usermod -aG samba tolga

# Output formatted text and pause for 3 seconds
echo -e "${BOLD}${BLUE}All done!${RESET}"
sleep 3

# Rest of the script execution...
