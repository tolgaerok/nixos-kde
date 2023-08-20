{ config, pkgs, lib, ... }:

let

  gitup = pkgs.writeScriptBin "gitup" ''
        #!/bin/bash

        # Tolga Erok
        # ¯\_(ツ)_/¯

        # 20/8/23

        # My nixos configuration file location
        config_files=(
            "$HOME/nixos/"
        )

        # Check if the remote URL is set to SSH
        remote_url=$(git remote get-url origin)

        # Rebase to reconcile divergent branches
        git pull origin main --rebase

        # Add some tweaks
        git config --global core.compression 9
        git config --global core.deltaBaseCacheLimit 2g
        git config --global diff.algorithm histogram
        git config --global http.postBuffer 524288000

        
        git_dir="$HOME/nixos/nixos.git"
        work_tree="$HOME/nixos"

        # Navigate to the working tree directory
        cd "$work_tree" || exit

        # Pull remote changes using merge
        git pull origin main --no-rebase
        echo "Pulled remote changes using merge"

        # Add and commit local changes
        for path in builtins.attrValues config_files; do
            git add "$path"
        done

        commit_time=$(date +"%I:%M %p") # 12-hour format
        git commit -m "update $(date) at $commit_time"
        echo "Committed local changes"

        # Handle file deletions
        for path in builtins.attrValues config_files; do
            git add --all "$path"
        done

        commit_time=$(date +"%I:%M %p") # Update commit time
        git commit -m "Edited commit @ $commit_time"
        echo "Committed edits"

        # Push changes to remote
        push_time=$(date +"%I:%M %p") # Update push time
        git push origin main
        echo "Pushed changes to remote repository at $push_time"

        # End of script
  '';

in {

  #---------------------------------------------------------------------
  # Type: gitup in terminal to execute above bash script
  #---------------------------------------------------------------------

  environment.systemPackages = [ gitup ];
}