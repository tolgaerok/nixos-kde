#!/usr/bin/env bash

set -euo pipefail

TARGET_HOST="${1:-}"
TARGET_USER="${2:-tolga}"

if [ "$(id -u)" -eq 0 ]; then
  echo "ERROR! $(basename "$0") should be run as a regular user"
  exit 1
fi

if [ ! -d "$HOME/Fresh-Install/nix-config/.git" ]; then
  git clone https://github.com/tolgaerok/nixos-kde.git "$HOME/Fresh-Install/nix-config"
fi

pushd "$HOME/Fresh-Install/nix-config"

if [[ -z "$TARGET_HOST" ]]; then
  echo "ERROR! $(basename "$0") requires a hostname as the first argument"
  echo "The following hosts are available:"
  ls nixos/*/*-configuration.nix 2>/dev/null | sed 's/.*\///;s/-configuration\.nix//'
  exit 1
fi

if [[ -z "$TARGET_USER" ]]; then
  echo "ERROR! $(basename "$0") requires a username as the second argument"
  echo "       The following users are available"
  ls -1 nixos/user/ | grep -v -E "nixos|root"
  exit 1
fi

# alot to be done
