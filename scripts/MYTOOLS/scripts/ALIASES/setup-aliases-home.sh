#!/usr/bin/env bash

# Tolga Erok
# Create alias into /root/.bashrc
# 16/7/2023

# IMPORTANT: dont run in sudo. execute as ./setup-alias-home.sh only

home_bashrc_file="$HOME/.bashrc"

# Check if .bashrc exists, create if it doesn't
if [[ ! -e "$home_bashrc_file" ]]; then
    touch "$home_bashrc_file"
fi

# Add aliases to .bashrc
cat <<EOF >>"$home_bashrc_file"
alias mynix='sudo ~/scripts/MYTOOLS/scripts/COMMAN-NIX-COMMAND-SCRIPT/MyNixOS-commands.sh'
alias mount='sudo ~/scripts/MYTOOLS/scripts/Mounting-Options/MOUNT-ALL.sh'
alias umount='sudo ~/scripts/MYTOOLS/scripts/Mounting-Options/UMOUNT-ALL.sh'
alias mse='sudo ~/scripts/MYTOOLS/MAKE-SCRIPTS-EXECUTABLE.sh'
alias htos='sudo ~/scripts/MYTOOLS/scripts/Zysnc-Options/ZYSNC-HOME-TO-SERVER.sh'
alias stoh='sudo ~/scripts/MYTOOLS/scripts/Zysnc-Options/ZYSNC-SERVER-TO-HOME.sh'
alias trimgen='sudo ~/scripts/MYTOOLS/scripts/GENERATION-TRIMMER/TrimmGenerations.sh'
EOF

YELLOW='\033[1;33m'
NC='\033[0m' # No color

echo -e "${YELLOW}\nEXECUTING: source /root/.bashrc\n${NC}"

commands=(
    "source $HOME/.bashrc"

)

# Echo and execute each command with a delay
for cmd in "${commands[@]}"; do
    echo -e "\e[34m${cmd}\e[0m"
    sleep 1
    eval "${cmd}"
done

# Echo completion message in yellow
echo -e "\e[33m\nScript execution completed.\e[0m"
echo "Aliases activated!"
