{ config, lib, ... }:

#---------------------------------------------------------------------
# Tolga Erok
# 22/10/23
# My personal home directory automator for KDE Plasma
#
# ¯\_(ツ)_/¯
#---------------------------------------------------------------------

let

  createCustomDirectories = ''
    echo ""
    for user_home in /home/*; do
     echo -e "\e[34m[\e[32m✔\e[34m] User directories created in: \e[32m$user_home\e[0m"
      username=$(basename "$user_home")

      # Skip populating directories in root and personal samba folder
      # ------------------------------------------------------------------
      if [[ "$username" != "root" && "$username" != "NixOs" ]]; then

        # Create standard directories
        # ------------------------------------------------------------------
        mkdir -p "$user_home/.config"
        mkdir -p "$user_home/.gnupg"
        mkdir -p "$user_home/.local/share/Steam"
        mkdir -p "$user_home/.local/share/direnv"
        mkdir -p "$user_home/.local/share/keyrings"
        mkdir -p "$user_home/.ssh"
        mkdir -p "$user_home/Applications"
        mkdir -p "$user_home/Documents"
        mkdir -p "$user_home/Downloads"
        mkdir -p "$user_home/Music"
        mkdir -p "$user_home/Pictures"
        mkdir -p "$user_home/Public"
        mkdir -p "$user_home/Templates"
        mkdir -p "$user_home/Videos"

        # Optional: Create user-specific configuration files
        # ------------------------------------------------------------------
        touch "$user_home/.bash_profile"
        touch "$user_home/.profile"

        # Get the user's primary group and set ownership
        # ------------------------------------------------------------------
        usergroup=$(id -gn "$username")
        chown -R "$username:$usergroup" \
          "$user_home/.bash_profile" \
          "$user_home/.config" \
          "$user_home/.gnupg" \
          "$user_home/.local/share/Steam" \
          "$user_home/.local/share/direnv" \
          "$user_home/.local/share/keyrings" \
          "$user_home/.ssh" \
          "$user_home/Applications" \
          "$user_home/Documents" \
          "$user_home/Downloads" \
          "$user_home/Music" \
          "$user_home/Pictures" \
          "$user_home/Public" \
          "$user_home/Templates" \
          "$user_home/Videos" \
          "$user_home/.profile"
      fi

    done

    # Print output in blue
    # ------------------------------------------------------------------
    echo -e "\n\e[34m[\e[32m✔\e[34m] User directories created, switching back into: \e[32m$HOME\e[34m"

  '';

in {
  config = {
    system.activationScripts.createCustomDirectories = createCustomDirectories;
  };
}
 