{ config, pkgs, lib, ... }:

let

  gitup = pkgs.writeScriptBin "gitup" ''
    #!/usr/bin/env bash

    # Personal nixos git folder uploader!!
    # Tolga Erok. ¯\_(ツ)_/¯..
    # 20/8/23.

    config_files="/etc/nixos"
    work_tree="/etc/nixos"
    start_time=$(date +%s)
    
    # Check if the remote URL is set to SSH
    remote_url=$(git remote get-url origin)

    # Configure Git credential helper to cache credentials for 1 hour
    git config --global credential.helper "cache --timeout=3600"

    # Configure pull to always rebase
    git config pull.rebase true
    git rm --cached .gitignore

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
    echo "(ツ)_/¯   Pulled remote changes using merge" | ${pkgs.lolcat}/bin/lolcat

    # Add changes
    git add "$config_files"

    commit_time=$(date +"%I:%M %p") # 12-hour format
    git commit -m "(ツ)_/¯    Update @ $commit_time"
    echo "(ツ)_/¯   Committed local changes" | ${pkgs.lolcat}/bin/lolcat

    # Commit changes from deletions
    git add --all
    git commit -m "(ツ)_/¯  Edited commit @ $commit_time"
    echo "(ツ)_/¯   Committed edits" | ${pkgs.lolcat}/bin/lolcat

    # Push changes to remote
    git push origin main
    echo "(ツ)_/¯   Pushed changes to remote repository @ $commit_time" | ${pkgs.lolcat}/bin/lolcat

    # Display Global settings
    git config --global --list

    end_time=$(date +%s)
    time_taken=$((end_time - start_time))

    notify-send --icon=ktimetracker --app-name="DONE" "Uploaded " "Completed:
    
        (ツ)_/¯
    Time taken: $time_taken
    " -u normal

  '';

in {

  #---------------------------------------------------------------------
  # Type: gitup in terminal to execute above bash script
  #---------------------------------------------------------------------

  environment.systemPackages = [ gitup ];
}
