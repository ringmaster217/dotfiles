# installation

## sway environment

After running `chezmoi apply`, modify `/usr/share/wayland-sessions/sway.desktop` to execute `/home/benwelker/.local/bin/cachy-sway`.

## fingerprint reader

```bash
sudo sed -i '1i auth    sufficient pam_fprintd.so' /etc/pam.d/sudo

if [[ -f /etc/pam.d/polkit-1 ]] && ! grep -q 'pam_fprintd.so' /etc/pam.d/polkit-1; then
  echo "Configuring polkit for fingerprint authentication..."
  sudo sed -i '1i auth      sufficient pam_fprintd.so' /etc/pam.d/polkit-1
elif [[ ! -f /etc/pam.d/polkit-1 ]]; then
  echo "Creating polkit configuration with fingerprint authentication..."
  sudo tee /etc/pam.d/polkit-1 >/dev/null <<'EOF'
auth      sufficient pam_fprintd.so
auth      required pam_unix.so

account   required pam_unix.so
password  required pam_unix.so
session   required pam_unix.so
EOF
fi

sudo fprintd-enroll benwelker
```