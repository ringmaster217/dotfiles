#!/bin/bash
set -euo pipefail

current_shell=$(getent passwd "$USER" | cut -d: -f7)
if [[ "$current_shell" != "/bin/bash" ]]; then
    sudo chsh -s /bin/bash "$USER"
fi
