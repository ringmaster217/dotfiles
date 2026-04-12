#!/bin/bash
set -euo pipefail

LIMINE_DEFAULT=/etc/default/limine

if [[ ! -f "$LIMINE_DEFAULT" ]]; then
    echo "No $LIMINE_DEFAULT found, skipping"
    exit 0
fi

# Remove quiet and splash from kernel cmdline
sudo sed -i \
    -e '/KERNEL_CMDLINE/ s/\bquiet\b//g' \
    -e '/KERNEL_CMDLINE/ s/\bsplash\b//g' \
    "$LIMINE_DEFAULT"

# Add plymouth.enable=0 if not already present
if ! grep -q 'plymouth\.enable=0' "$LIMINE_DEFAULT"; then
    sudo sed -i '/KERNEL_CMDLINE/ s/"$/ plymouth.enable=0"/' "$LIMINE_DEFAULT"
fi

# Clean up any double spaces left by removals
sudo sed -i -E '/KERNEL_CMDLINE/ s/ +/ /g' "$LIMINE_DEFAULT"

sudo limine-mkinitcpio
