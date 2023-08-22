{ config, pkgs, lib, ... }:

let

  gitup = pkgs.writeScriptBin "gitup" ''
    #!/bin/bash

    # Personal nixos git folder uploader!!
    # Tolga Erok. ¯\_(ツ)_/¯
    # 20/8/23

    config_files="$HOME/nixos"
    work_tree="$HOME/nixos"

    # Check if the remote URL is set to SSH
    remote_url=$(git remote get-url origin)

    # Configure Git credential helper to cache credentials for 1 hour
    git config --global credential.helper "cache --timeout=3600"

    # Configure pull to always rebase
    git config pull.rebase true

    # Add some tweaks
    git config --global core.compression 9
    git config --global core.deltaBaseCacheLimit 2g
    git config --global diff.algorithm histogram
    git config --global http.postBuffer 524288000

    if [[ $remote_url == *"git@github.com"* ]]; then
        echo "Remote URL is set to SSH. Proceeding with the script..." | ${pkgs.lolcat}/bin/lolcat
    else
        echo "Remote URL is not set to SSH. Please set up SSH key-based authentication for the remote repository."
        echo "If you haven't already, generate an SSH key pair:"
        echo "ssh-keygen -t ed25519 -C 'your email'"
        echo "Add your SSH key to the agent:"
        echo "eval \$(ssh-agent -s)"
        echo "ssh-add ~/.ssh/id_ed25519"
        echo "Then, add your SSH public key to your GitHub account:"
        echo "cat ~/.ssh/id_ed25519.pub"
        echo "Finally, update your Git configuration to use SSH:"
        echo "git config --global credential.helper store"
        echo "Remote URL needs to be updated to SSH. Exiting..."
        exit 1
    fi

    # Navigate to the working tree directory
    cd "$work_tree" || exit

    # Pull remote changes using merge
    git pull origin main --no-rebase
    echo "Pulled remote changes using merge" | ${pkgs.lolcat}/bin/lolcat

    # Add changes
    git add "$config_files"

    # Commit changes and display filenames/folders
    git status -s | while read -r line; do
        file_status=$(echo "$line" | awk '{ print $1 }')
        file_name=$(echo "$line" | awk '{ print $2 }')
        echo "Adding $file_status: $file_name"
    done

    commit_time=$(date +"%I:%M %p") # 12-hour format
    git commit -m "Update at $commit_time"
    echo "Committed local changes" | ${pkgs.lolcat}/bin/lolcat

    # Commit changes from deletions
    git add --all
    git commit -m "Edited commit @ $commit_time"
    echo "Committed edits" | ${pkgs.lolcat}/bin/lolcat

    # Push changes to remote
    git push origin main
    echo "Pushed changes to remote repository at $commit_time" | ${pkgs.lolcat}/bin/lolcat

    # Display Global settings
    git config --global --list

    # End of script

  '';

in {

  #---------------------------------------------------------------------
  # Type: gitup in terminal to execute above bash script
  #---------------------------------------------------------------------

  environment.systemPackages = [ gitup ];
}
