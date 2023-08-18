#!/bin/bash

# Tolga Erok
# git remote set-url origin git@github.com:tolgaerok/nixos.git


config_files=(
    ~/nixos/nixos/*
)

git_dir="$HOME/nixos/nixos/.git"
work_tree="$HOME"


for file in "${config_files[@]}"; do
    git --git-dir="$git_dir" --work-tree="$work_tree" add "$file"
done

git --git-dir="$git_dir" --work-tree="$work_tree" commit -m "update $(date)"
git --git-dir="$git_dir" --work-tree="$work_tree" push