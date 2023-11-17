{ config, pkgs, lib, ... }:

let

  nixos-hm = pkgs.writeScriptBin "nixos-hm" ''
    #!/bin/sh
    # Personal home-manager auto installer
    # Tolga Erok. ¯\_(ツ)_/¯
    # 8/8/2023

    ################################################################################
    ##                                                                            ##
    ##                    Auto-install script for home-manager                    ##
    ##                                                                            ##
    ################################################################################

    set -e
    set -x

    ################################################################################
    ##                                  Options                                   ##
    ################################################################################

    host="nixos-host"
    user="user"

    { set +x; } 2> /dev/null

    ################################################################################
    ##                             Helper Functions                                ##
    ################################################################################

    # Function to print formatted messages
    msg() {
      printf "\n\e[32m=> $1\e[0m\n\n"
    }

    # Function to confirm actions with the user
    confirm() {
      read -r -p "Do you want to continue? [Y/n] " response
      case "$response" in
        [nN][oO]|[nN]) return 1 ;;
        *) return 0 ;;
      esac
    }

    ################################################################################
    ##                                   Script                                   ##
    ################################################################################

    msg "Installing the home-manager channel..."
    (
        set -x
        sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz home-manager
        sudo nix-channel --update
    )

    msg "Linking the root user’s home configuration..."
    (
        set -x
        sudo mkdir -p /root/.config/nixpkgs
        sudo ln -s "/home/$user/config/confkit/Nix/root.nix" /root/.config/nixpkgs/home.nix
        sudo nix-shell '<home-manager>' -A install
    )

    msg "Linking your home configuration..."
    (
        set -x
        mkdir -p "$HOME/.config/nixpkgs"
        ln -s "../../config/Nix/$host/$user.nix" "$HOME/.config/nixpkgs/home.nix"
        nix-shell '<home-manager>' -A install
    )

    printf '\n\e[32m\e[1mInstallation complete!\e[0m\n\n'
    printf "You can now restart your shell."

  '';

in {

  #---------------------------------------------------------------------
  # Type: nixos-hm in terminal to execute the above bash script
  #---------------------------------------------------------------------

  environment.systemPackages = [ nixos-hm ];
}
