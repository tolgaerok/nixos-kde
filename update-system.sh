#!/bin/sh
# Update system nixos packages

sudo nix-channel --update

./update-user.sh

