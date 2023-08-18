#!/bin/bash

# Tolga Erok

config_files=(
    ~/nixos/A
)

git_dir="$HOME/nixos/"
work_tree="$HOME"

for file in "${config_files[@]}"; do
    git --git-dir="$git_dir" --work-tree="$work_tree" add "$file"
done

git --git-dir="$git_dir" --work-tree="$work_tree" commit -m "update $(date)"
git --git-dir="$git_dir" --work-tree="$work_tree" push