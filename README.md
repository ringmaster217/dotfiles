# Installation

## Chezmoi

- install chezmoi with `pacman -Syu chezmoi`
- run `chezmoi init --apply ringmaster217`

## Post-chezmoi

### sway environment

`cachy-sway` (in `~/.local/bin`) is what sets `PATH` to include `~/.local/bin`
before starting sway — this is required for the wallpaper/lock/wifi scripts to
work when invoked via sway keybindings, autostart, or waybar (they don't go
through a login shell, so `~/.bashrc` never runs).

This is configured automatically during `chezmoi apply` via
`.chezmoiscripts/run_onchange_after_configure-sway-session.sh`, which:
1. Creates a persistent override at `/usr/local/share/wayland-sessions/sway.desktop`
   pointing `Exec` to `cachy-sway` (SDDM reads `/usr/local/share` before `/usr/share`,
   and `pacman` never touches `/usr/local`).
2. Installs a pacman hook at `/etc/pacman.d/hooks/sway-cachy.hook` so that even if
   `/usr/share/wayland-sessions/sway.desktop` is updated by a package upgrade (`pacman -Syu`),
   it gets re-patched automatically.

### fingerprint reader

```bash
sudo fprintd-enroll benwelker
```
