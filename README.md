# dotfiles — CachyOS / Niri

Personal dotfiles for **CachyOS Linux** with **Niri** (Wayland) on **NVIDIA RTX 3060 Mobile** (hybrid Intel + NVIDIA).

Stack: Niri, Waybar, Rofi, Kitty, Dunst, fastfetch, starship, fish/zsh, Vesktop, fnm, bun, Docker.

## Contents

| Package | Path | Description |
|---------|------|-------------|
| fastfetch | `fastfetch/.config/fastfetch/` | Impr-inspired Nord monochrome (`SYSTEM` `#88C0D0`, `HARDWARE` `#5E81AC`), kitty image logo with random selection (`assets/fastfetch-images/*.jpg`, 11 Gran Turismo/JDM images), separator `›` |
| starship | `starship/.config/starship.toml` | Custom single-line prompt with Dune to Nord palette (` OS  dir  git  time ❯`), colors `#2E3440`/`#4C566A`/`#3B4252` |
| fish | `fish/.config/fish/` | Fish config with starship init, fastfetch on startup, fnm env, eza alias |
| zsh | `zsh/.zshrc` | Zsh config based on cachyos-zsh-config with starship and fastfetch |
| niri | `niri/.config/niri/` | Niri compositor modular config (`config.kdl` + `config.d/10-input` through `90-user-extra`), Niri 26.04 Wayland |
| vesktop | `vesktop/.config/vesktop/` + `applications/` | Vesktop fix for NVIDIA Wayland (`LIBVA_DRIVER_NAME=iHD DRI_PRIME=0 --disable-gpu-sandbox --enable-features=VaapiVideoDecoder`), fixes `wayland is not compatible with Vulkan` |
| images | `fastfetch/.config/fastfetch/assets/fastfetch-images/` | Kitty image assets for fastfetch |

## Requirements

```bash
sudo pacman -S stow fastfetch starship fish kitty zsh niri waybar rofi dunst git
# Optional
sudo pacman -S docker docker-compose bun fnm vesktop libva-utils
```

## Installation

### 1. Clone

```bash
git clone https://github.com/PabloJustDevelops/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Install with stow (recommended)

```bash
chmod +x install.sh
./install.sh
# Equivalent to:
# stow -t ~ fastfetch starship fish zsh niri vesktop applications
```

The install script runs `stow -v -t ~ <package>` for each directory. This creates symlinks such as `~/.config/fastfetch -> ~/dotfiles/fastfetch/.config/fastfetch`.

### 3. Manual without stow

```bash
cp -r fastfetch/.config/fastfetch ~/.config/
cp starship/.config/starship.toml ~/.config/
# etc.
```

### 4. Post-install

```bash
niri msg action reload-config
fastfetch
starship --version
```

## Notes for contributors and AI agents

- **Stow structure:** each top-level directory is a stow package. Do not copy `.git` or `README.md`.
- **System packages:** `stow`, `fastfetch`, and `starship` are in the `extra` repository. Do not install AUR packages without confirmation.
- **Fastfetch images:** add new images to `~/Imágenes/fastfetch-images/*.jpg` and copy to `fastfetch/.config/fastfetch/assets/fastfetch-images/` for versioning. The config uses the wildcard `*.jpg` (random on each run, kitty protocol in Kitty, text fallback elsewhere).
- **Vesktop fix:** requires `LIBVA_DRIVER_NAME=iHD DRI_PRIME=0` and `--disable-gpu-sandbox` due to `wayland is not compatible with Vulkan` on Electron with NVIDIA Wayland. The desktop file in `applications/` already includes this.

## Updating

```bash
cd ~/dotfiles
git pull
./install.sh
```

## License

MIT
