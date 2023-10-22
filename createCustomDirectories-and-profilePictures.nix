{ config, lib, ... }:

#---------------------------------------------------------------------
# Tolga Erok
# 22/10/23
# My personal profile picture and home directory automator
#
# ¯\_(ツ)_/¯
#---------------------------------------------------------------------

let

  createProfilePictures = ''
    # Create the profile picture directory
    # ------------------------------------------------------------------
    mkdir -p /var/lib/AccountsService/icons

    # Loop through user home directories
    # ------------------------------------------------------------------
    for user_home in /home/*; do
      if [[ -d "$user_home" ]]; then
        username=$(basename "$user_home")
        
        # Check if the user is not 'root' or 'NixOs'
        # ------------------------------------------------------------------
        if [[ "$username" != "root" && "$username" != "NixOs" ]]; then
          profile_pic_dest="/var/lib/AccountsService/icons/$username"

          # Check if the profile picture doesn't exist for the user, then copy it
          # -----------------------------------------------------------------------
          if [[ ! -h "$profile_pic_dest" ]]; then
            profile_pic_src="/etc/nixos/SETUP/profile-pics/$username-profile.png"
            cp "$profile_pic_src" "$profile_pic_dest"
          fi
        fi
      fi
    done
  '';

  createCustomDirectories = ''
    echo ""
    for user_home in /home/*; do
     echo -e "\e[34mUser directories created in: \e[32m$user_home\e[0m"
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
        chown -R "$username:$usergroup" \
          "$user_home/Documents" \
          "$user_home/Downloads" \
          "$user_home/Pictures" \
          "$user_home/Music" \
          "$user_home/Videos" \
          "$user_home/Public" \
          "$user_home/Templates" \
          "$user_home/.config" \
          "$user_home/.ssh" \
          "$user_home/.bash_profile" \
          "$user_home/.profile"
      fi

    done

    # Print output in blue
    # ------------------------------------------------------------------
    echo -e "\n\e[34mUser directories created, switching back into: \e[32m$HOME\e[34m\n"
    echo -e "\e[34mUser profile pictures set\e[0m\n"
  '';

in {
  config = {
    system.activationScripts.createProfilePictures = createProfilePictures;
    system.activationScripts.createCustomDirectories = createCustomDirectories;
  };
}
