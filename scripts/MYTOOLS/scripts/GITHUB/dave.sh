#!/bin/bash

# Tolga 17/8/23
# idea's for dave

config_files=(
    ~/.config/alacritty
    ~/.config/picom
    ~/.dwm
    ~/.mutt
    ~/.muttrc
    ~/.newsboat
    ~/Documents
    ~/Programs
)

git_dir="$HOME/.cfg/"
work_tree="$HOME"

for file in "${config_files[@]}"; do
    git --git-dir="$git_dir" --work-tree="$work_tree" add "$file"
done

git --git-dir="$git_dir" --work-tree="$work_tree" commit -m "update $(date)"
git --git-dir="$git_dir" --work-tree="$work_tree" push