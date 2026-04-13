#!/bin/bash
set -euo pipefail

SDDM_CONF_DIR=/etc/sddm.conf.d
SDDM_AUTOLOGIN_CONF="$SDDM_CONF_DIR/autologin.conf"

sudo mkdir -p "$SDDM_CONF_DIR"

sudo tee "$SDDM_AUTOLOGIN_CONF" > /dev/null <<EOF
[Autologin]
User=$USER
Session=sway
EOF

echo "SDDM auto-login configured for user '$USER' with session 'sway'"
