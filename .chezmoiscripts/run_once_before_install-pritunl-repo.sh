#!/bin/bash
set -euo pipefail

if ! grep -q '^\[pritunl\]' /etc/pacman.conf; then
    sudo tee -a /etc/pacman.conf > /dev/null << EOF

[pritunl]
Server = https://repo.pritunl.com/stable/pacman
EOF
fi

if ! pacman-key --list-keys 7568D9BB55FF9E5287D586017AE645C0CF8E292A &>/dev/null; then
    curl -fsSL https://raw.githubusercontent.com/pritunl/pgp/master/pritunl_repo_pub.asc \
      | sudo pacman-key --add -
    sudo pacman-key --lsign-key 7568D9BB55FF9E5287D586017AE645C0CF8E292A
fi