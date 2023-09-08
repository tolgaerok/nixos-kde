{ config, pkgs, lib, ... }:

let

  auto-home-manager = pkgs.writeScriptBin "auto-home-manager" ''
    #!/bin/sh

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

    host=nixos-host
    user=user

    { set +x; } 2> /dev/null

    ################################################################################
    ##                                   Script                                   ##
    ################################################################################

    # Install the home-manager channel.
    printf "\n\e[32m=> Installing the home-manager channel...\e[0m\n\n"
    (
        set -x
        sudo nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
        sudo nix-channel --update
    )

    # Link the root user’s home configuration.
    printf "\n\e[32m=> Linking the root user’s home configuration...\e[0m\n\n"
    (
        set -x
        sudo mkdir -p /root/.config/nixpkgs
        sudo ln -s /home/$user/config/confkit/Nix/root.nix /root/.config/nixpkgs/home.nix
        sudo nix-shell '<home-manager>' -A install
        sudo git clone https://github.com/chisui/zsh-nix-shell.git /root/.zsh-custom/plugins/nix-shell
        sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /root/.zsh-custom/plugins/zsh-syntax-highlighting
    )

    # Link your home configuration.
    printf "\n\e[32m=> Linking your home configuration...\e[0m\n\n"
    (
        set -x
        mkdir -p $HOME/.config/nixpkgs
        ln -s ../../config/Nix/$host/$user.nix $HOME/.config/nixpkgs/home.nix
        nix-shell '<home-manager>' -A install
        git clone https://github.com/chisui/zsh-nix-shell.git $HOME/.zsh-custom/plugins/nix-shell
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.zsh-custom/plugins/zsh-syntax-highlighting
    )

    printf "\n\e[32m\e[1mInstallation complete!\e[0m\n\n"
    printf "You can now restart your shell."

  '';

in {

  #---------------------------------------------------------------------
  # Type: auto-home-manager in terminal to execute above bash script
  #---------------------------------------------------------------------

  environment.systemPackages = [ auto-home-manager ];
}
