#!/bin/bash
set -euo pipefail

USER_HOME="${HOME}"
if [[ -n "${SUDO_USER:-}" && "$USER_HOME" == "/root" ]]; then
    USER_HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)
fi

CACHY_SWAY="${USER_HOME}/.local/bin/cachy-sway"
LOCAL_WAYLAND_SESSIONS_DIR=/usr/local/share/wayland-sessions
SWAY_LOCAL_DESKTOP="$LOCAL_WAYLAND_SESSIONS_DIR/sway.desktop"
SWAY_SYS_DESKTOP=/usr/share/wayland-sessions/sway.desktop
PACMAN_HOOKS_DIR=/etc/pacman.d/hooks
PACMAN_HOOK="$PACMAN_HOOKS_DIR/sway-cachy.hook"

# 1. Create a persistent desktop entry in /usr/local/share/wayland-sessions/
# Pacman never touches /usr/local, so SDDM will use this without pacman overwriting it.
sudo mkdir -p "$LOCAL_WAYLAND_SESSIONS_DIR"

if [[ -f "$SWAY_SYS_DESKTOP" ]]; then
    sudo cp "$SWAY_SYS_DESKTOP" "$SWAY_LOCAL_DESKTOP"
else
    sudo tee "$SWAY_LOCAL_DESKTOP" > /dev/null <<EOF
[Desktop Entry]
Name=Sway
Comment=An i3-compatible Wayland compositor
Exec=$CACHY_SWAY
Type=Application
DesktopNames=sway;wlroots;swayfx
EOF
fi

sudo sed -i "s|^Exec=.*|Exec=$CACHY_SWAY|" "$SWAY_LOCAL_DESKTOP"

# 2. Update the system entry in /usr/share/wayland-sessions/sway.desktop as well
if [[ -f "$SWAY_SYS_DESKTOP" ]]; then
    sudo sed -i "s|^Exec=.*|Exec=$CACHY_SWAY|" "$SWAY_SYS_DESKTOP"
fi

# 3. Install a pacman hook as a safeguard so /usr/share/wayland-sessions/sway.desktop
# is automatically re-patched if pacman updates the sway package.
sudo mkdir -p "$PACMAN_HOOKS_DIR"
sudo tee "$PACMAN_HOOK" > /dev/null <<EOF
[Trigger]
Type = Path
Operation = Install
Operation = Upgrade
Target = usr/share/wayland-sessions/sway.desktop

[Trigger]
Type = Package
Operation = Install
Operation = Upgrade
Target = sway

[Action]
Description = Pointing sway.desktop to cachy-sway wrapper...
When = PostTransaction
Exec = /usr/bin/sed -i 's|^Exec=.*|Exec=$CACHY_SWAY|' /usr/share/wayland-sessions/sway.desktop
EOF

echo "Sway session configured to use $CACHY_SWAY"
