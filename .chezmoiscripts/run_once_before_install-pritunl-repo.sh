#!/bin/bash

sudo tee -a /etc/pacman.conf << EOF
[pritunl]
Server = https://repo.pritunl.com/stable/pacman
EOF

curl -fsSL https://raw.githubusercontent.com/pritunl/pgp/master/pritunl_repo_pub.asc \
  | sudo pacman-key --add -
sudo pacman-key --lsign-key 7568D9BB55FF9E5287D586017AE645C0CF8E292A