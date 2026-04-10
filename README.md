# Installation

## Post-chezmoi

### sway environment

After running `chezmoi apply`, modify `/usr/share/wayland-sessions/sway.desktop` to execute `/home/benwelker/.local/bin/cachy-sway`.

### fingerprint reader

```bash
sudo fprintd-enroll benwelker
```
