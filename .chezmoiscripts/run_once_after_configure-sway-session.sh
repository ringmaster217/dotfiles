#!/bin/bash
set -euo pipefail

SWAY_DESKTOP=/usr/share/wayland-sessions/sway.desktop

if [[ ! -f "$SWAY_DESKTOP" ]]; then
    echo "No $SWAY_DESKTOP found, skipping"
    exit 0
fi

sudo sed -i 's|^Exec=.*|Exec=/home/benwelker/.local/bin/cachy-sway|' "$SWAY_DESKTOP"
