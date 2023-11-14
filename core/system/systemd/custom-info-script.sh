#!/run/current-system/sw/bin/sh
# Tolga Erok

# Reload the sysctl Configuration
# doas sysctl --system

# Set PATH to include the necessary command directories
export PATH="/run/current-system/sw/bin:$PATH"

# Fetch RAM information
RAM_INSTALLED=$(free -h | awk '/^Mem/ {print $2}')
RAM_USED=$(free -h | awk '/^Mem/ {print $3}')

# Fetch and filter tmpfs information from df, including device information
# TMPFS_USED=$(df -h | awk '/tmpfs/ {print $1 "\t" $3 "\t" $5}' | column -t)
TMPFS_USED=$(df -h)

# Fetch zramswap information
ZRAMSWAP_USED=$(zramctl | grep /dev/zram0 | awk '{print $4}')

# Fetch earlyoom information
EARLYOOM_USED=$(pgrep earlyoom &>/dev/null && echo -e "\e[32mRunning\e[34m" || echo -e "\e[31mNot Running\e[34m")

# Check if the service is active
if systemctl --quiet is-active configure-flathub-repo.service; then
    FLATHUB_ACTIVE="\e[32mActive\e[0m"
else
    FLATHUB_ACTIVE="\e[33mInactive\e[0m"
fi

# Check if the service is enabled (loaded)
if systemctl is-enabled configure-flathub-repo.service; then
    FLATHUB_LOADED="\e[32mLoaded\e[0m"
else
    FLATHUB_LOADED="\e[33mNot Loaded\e[0m"
fi

#if flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo; then
#    echo -e "\e[34m[\e[32m✔\e[34m]  Flathub repo added and configured successfully \e[32m¯\_(ツ)_/¯\e[0m\n "
#else
#    echo -e "\e[34m[\e[31m✘\e[34m]  \e[31mError:\e[34m Failed to configure Flathub repo \e[31m¯\_(ツ)_/¯\e[0m\n"
#fi

stdbuf -o0 printf ""
echo -e "\e[1;32m[✔]\e[0m Restarting kernel tweaks...\n"
sleep 1
sudo sysctl --system
sleep 1

# Print descriptions in yellow and results in blue
printf "\n\e[33mRAM Installed:\e[0m %s\n" "$RAM_INSTALLED"
printf "\e[33mRAM Used:\e[0m %s\n" "     $RAM_USED"
printf "\n\e[33mDisk space and TMPS Used:\e[0m\n%s\n" "$TMPFS_USED"
printf "\n\e[33mZRAMSWAP Used:\e[0m %s\n" "  $ZRAMSWAP_USED"
printf "\e[33mEarlyoom Status:\e[0m %s\n" "$EARLYOOM_USED"
echo -e "\nFlathub Service Status: $FLATHUB_ACTIVE / $FLATHUB_LOADED"

lfs 
duf
figlet system updated
# espeak -v en+m7 -s 165 "system! up! dated!  kernel! tweaks! applied!" --punct="," 2>/dev/null
