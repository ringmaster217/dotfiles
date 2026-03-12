#!/bin/bash
set -euo pipefail

if command -v paru &>/dev/null; then
    echo "paru is already installed, skipping bootstrap"
    exit 0
fi

echo "Installing paru AUR helper..."

# Ensure build dependencies are present
sudo pacman -S --needed --noconfirm base-devel git

# Build and install paru in a temporary directory
BUILDDIR=$(mktemp -d)
trap 'rm -rf "$BUILDDIR"' EXIT

git clone https://aur.archlinux.org/paru.git "$BUILDDIR/paru"
pushd "$BUILDDIR/paru"
makepkg -si --noconfirm
popd

echo "paru installed successfully"
