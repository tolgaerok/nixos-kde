{ config, lib, ... }:

let
  setGnomeProfilePicture = ''
    mkdir -p /var/lib/AccountsService/icons
    if [[ ! -h /var/lib/AccountsService/icons/tolga ]]; then
      cp /etc/nixos/SETUP/profile-pics/cool-tolga-2.png /var/lib/AccountsService/icons/tolga
      cp /etc/nixos/SETUP/profile-pics/smile.jpg /var/lib/AccountsService/icons/SOS
    fi
  '';

  createCustomDirectories = ''
    for user_home in /home/*; do
      if [[ -d "$user_home" && -e "$user_home/.bashrc" ]]; then
        username=$(basename "$user_home")
        if [[ "$username" != "NixOs" ]]; then
          cd "$user_home"
          mkdir -p Batman

          # Create directories in the user's home directory
          mkdir -p Desktop
          mkdir -p Documents
          mkdir -p Downloads
          mkdir -p Pictures
          mkdir -p Music
          mkdir -p Videos
          mkdir -p Public
          mkdir -p Templates

          # Optional: Create hidden directories and files
          mkdir -p .config
          mkdir -p .ssh

          # Optional: Create user-specific configuration files
          touch .bash_profile
          touch .bashrc
          touch .profile
          sleep 2

          # Get the user's primary group and set ownership
          usergroup=$(id -gn "$username")
          chown -R "$username:$usergroup" Batman
          chown -R "$username:$usergroup" Desktop Documents Downloads Pictures Music Videos Public Templates
          chown -R "$username:$usergroup" .config .ssh .bash_profile .bashrc .profile
        fi
      fi
    done

    # Print "User directories created" in blue
    echo -e "\n\e[34mUser directories created in:\e[0m $HOME\e[0m\n"
  '';
in {
  options = {
    Batman = {
      enable = lib.mkEnableOption
        "Enable the Batman directory creation and profile picture setup";
    };
  };

  config = {
    system.activationScripts.setGnomeProfilePicture =
      if config.Batman.enable then setGnomeProfilePicture else "";

    # Execute the createCustomDirectories script for all user home directories
    system.activationScripts.createCustomDirectories = createCustomDirectories;
  };
}
