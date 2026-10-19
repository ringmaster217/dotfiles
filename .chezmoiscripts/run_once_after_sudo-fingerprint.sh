#!/bin/bash
set -euo pipefail

if ! grep -q 'pam_fprintd\.so' /etc/pam.d/sudo; then
    sudo sed -i '1i auth    sufficient pam_fprintd.so' /etc/pam.d/sudo
fi
