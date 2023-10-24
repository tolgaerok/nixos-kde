{ config, lib, ... }:

#---------------------------------------------------------------------
# Tolga Erok
# 22/10/23
# My personal profile picture automator for KDE Plasma
#
# ¯\_(ツ)_/¯
#---------------------------------------------------------------------

let

  createProfilePictures = ''
    # Create profile picture directory
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

            # If user-specific profile picture doesn't exist, set the default profile picture
            # --------------------------------------------------------------------------------
            if [[ ! -e "$profile_pic_src" ]]; then
              profile_pic_src="/etc/nixos/SETUP/profile-pics/default-profile.png"
            fi

            cp "$profile_pic_src" "$profile_pic_dest"
          fi
        fi
      fi
    done
    # Print output in blue
    # ------------------------------------------------------------------    
    echo -e "\e[33m[\e[32m✔\e[33m] User profile pictures set\e[0m\n"
  '';

in {
  config = {
    system.activationScripts.createProfilePictures = createProfilePictures;

  };
}
