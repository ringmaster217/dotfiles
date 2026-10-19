#!/bin/bash
set -euo pipefail

AUTOLOGIN_USER="benwelker"
SDDM_CONF_DIR=/etc/sddm.conf.d
SDDM_AUTOLOGIN_CONF="$SDDM_CONF_DIR/autologin.conf"

sudo mkdir -p "$SDDM_CONF_DIR"

sudo tee "$SDDM_AUTOLOGIN_CONF" > /dev/null <<EOF
[Autologin]
User=$AUTOLOGIN_USER
Session=sway
EOF

echo "SDDM auto-login configured for user '$AUTOLOGIN_USER' with session 'sway'"
