#!/run/current-system/sw/bin/sh

# Set PATH to include the necessary command directories
export PATH="/run/current-system/sw/bin:$PATH"

# Fetch RAM information
RAM_INSTALLED=$(free -h | awk '/^Mem/ {print $2}')
RAM_USED=$(free -h | awk '/^Mem/ {print $3}')

# Fetch and filter tmpfs information from df, including device information
TMPFS_USED=$(df -h | awk '/tmpfs/ {print $1 "\t" $3 "\t" $5}' | column -t)

# Fetch zramswap information
ZRAMSWAP_USED=$(zramctl | grep /dev/zram0 | awk '{print $4}')

# Fetch earlyoom information
EARLYOOM_USED=$(pgrep earlyoom &>/dev/null && echo "Running" || echo "Not Running")

# Print descriptions in yellow and results in blue
printf "\e[33mRAM Installed:\e[0m %s\n" "$RAM_INSTALLED"
printf "\e[33mRAM Used:\e[0m %s\n" "$RAM_USED"
printf "\e[33mTMPFS Used:\e[0m\n%s\n" "$TMPFS_USED"
printf "\e[33mZRAMSWAP Used:\e[0m %s\n" "$ZRAMSWAP_USED"
printf "\e[33mEarlyoom Status:\e[0m %s\n" "$EARLYOOM_USED"
