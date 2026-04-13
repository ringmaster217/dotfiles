#!/bin/bash
set -euo pipefail

sudo mkdir -p /etc/iwd

sudo tee /etc/iwd/main.conf > /dev/null << 'EOF'
[General]
EnableNetworkConfiguration=true
EOF
