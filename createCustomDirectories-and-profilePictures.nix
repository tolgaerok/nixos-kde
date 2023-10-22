{ config, lib, ... }:

# version 2

#---------------------------------------------------------------------
# Tolga Erok
# 22/10/23
# My personal $HOME directory populator
#
# ¯\_(ツ)_/¯
#---------------------------------------------------------------------

let

  createProfilePictures = ''
    # Create profile picture directory
    # ------------------------------------------------------------------
    mkdir -p /var/lib/AccountsService/icons

    # Check if exists then copy the custom user profile pictures
    # ------------------------------------------------------------------
    if [[ ! -h /var/lib/AccountsService/icons/tolga ]]; then
      cp /etc/nixos/SETUP/profile-pics/cool-tolga-2.png /var/lib/AccountsService/icons/tolga
      cp /etc/nixos/SETUP/profile-pics/smile.jpg /var/lib/AccountsService/icons/SOS
    fi
  '';

  createCustomDirectories = ''
    echo ""
    for user_home in /home/*; do
     echo -e "\e[34mUser directories created in:\e[0m $user_home\e[0m"
      username=$(basename "$user_home")

      # Skip populating directories in root and personal samba folder
      # ------------------------------------------------------------------

      if [[ "$username" != "root" && "$username" != "NixOs" ]]; then

        # Create standard directories
        # ------------------------------------------------------------------
        mkdir -p "$user_home/Documents"
        mkdir -p "$user_home/Downloads"
        mkdir -p "$user_home/Pictures"
        mkdir -p "$user_home/Music"
        mkdir -p "$user_home/Videos"
        mkdir -p "$user_home/Public"
        mkdir -p "$user_home/Templates"
        mkdir -p "$user_home/.config"
        mkdir -p "$user_home/.ssh"

        # Optional: Create user-specific configuration files
        # ------------------------------------------------------------------
        touch "$user_home/.bash_profile"
        touch "$user_home/.profile"

        # Get the user's primary group and set ownership
        # ------------------------------------------------------------------
        usergroup=$(id -gn "$username")
        chown -R "$username:$usergroup" "$user_home/Documents" "$user_home/Downloads" "$user_home/Pictures" "$user_home/Music" "$user_home/Videos" "$user_home/Public" "$user_home/Templates" "$user_home/.config" "$user_home/.ssh" "$user_home/.bash_profile" "$user_home/.profile"
      fi

    done

    # Print output in blue
    # ------------------------------------------------------------------
    echo -e "\n\e[34mUser directories created, switching back into:\e[0m $HOME\e[0m\n"
    echo -e "\e[34mUser User profile picture's set\e[0m\n"
  '';

in {
  config = {
    system.activationScripts.createProfilePictures = createProfilePictures;
    system.activationScripts.createCustomDirectories = createCustomDirectories;
  };
}
