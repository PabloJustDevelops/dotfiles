# dotfiles — CachyOS / Niri · fastfetch Impr Nord · Starship Dune

Dotfiles personales para **CachyOS Linux** con **Niri** (Wayland), **NVIDIA RTX 3060 Mobile** (híbrida Intel+NVIDIA), **fish/zsh + starship**, **fastfetch** y **Vesktop**.

> **Stack actual:** Niri · Waybar · Rofi · Kitty · Dunst · fastfetch · starship · fish/zsh · Vesktop · fnm/bun · Docker

---

## ✨ Qué incluye

| Paquete | Ruta | Descripción |
|---------|------|-------------|
| **fastfetch** | `fastfetch/.config/fastfetch/` | Impr Dune → Nord monochrome (`SYSTEM` `#88C0D0`, `HARDWARE` `#5E81AC`), logo `kitty` random (`assets/fastfetch-images/*.jpg` — 11 imágenes Gran Turismo/JDM), `display.separator` `›` |
| **starship** | `starship/.config/starship.toml` | Barra custom 1 línea Dune → Nord (` OS  dir  git  time ❯`), colores `#FFD700`/`#F0B030`/`#C8960C` → Nord `#2E3440`/`#4C566A` |
| **fish** | `fish/.config/fish/` | `config.fish` con `starship init`, `fastfetch` inicial, `fnm env`, `eza` alias |
| **zsh** | `zsh/.zshrc` | `cachyos-zsh-config` + `starship` + `fastfetch` + `inir` sequences |
| **niri** | `niri/.config/niri/` | `config.kdl` modular (`config.d/10-input`…`90-user-extra`), Niri 26.04 Wayland |
| **vesktop** | `vesktop/.config/vesktop/` + `applications/` | Fix VAAPI Intel `LIBVA_DRIVER_NAME=iHD DRI_PRIME=0 --disable-gpu-sandbox --enable-features=VaapiVideoDecoder` para Wayland/NVIDIA 610 |
| **images** | `fastfetch/.config/fastfetch/assets/fastfetch-images/` | 11 imágenes kitty (Gran Turismo, pixel car, R32, lowpoly) — añade más en `~/Imágenes/fastfetch-images/*.jpg` |

---

## 📦 Requisitos

```bash
sudo pacman -S stow fastfetch starship fish kitty zsh niri waybar rofi dunst git
# Opcionales del setup
sudo pacman -S docker docker-compose bun fnm vesktop libva-utils
```

---

## 🚀 Instalación (humano y IA)

### 1. Clonar

```bash
git clone https://github.com/PabloJustDevelops/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Instalar con stow (recomendado)

```bash
chmod +x install.sh
./install.sh
# Equivale a:
# stow -t ~ fastfetch starship fish zsh niri vesktop applications
```

`install.sh` hace `stow -v -t ~ <paquete>` para cada carpeta. Crea symlinks `~/.config/fastfetch -> ~/dotfiles/fastfetch/.config/fastfetch`, etc.

### 3. Manual sin stow

```bash
cp -r fastfetch/.config/fastfetch ~/.config/
cp starship/.config/starship.toml ~/.config/
# ... etc
```

### 4. Post-instalación

```bash
# Recargar Niri
niri msg action reload-config

# Verificar
fastfetch              # debe mostrar logo random kitty + Nord
starship --version
fish -c "fastfetch"    # fetch inicial ya en fish/zsh
```

---

## 🤖 Para IAs / Agentes

- **Estructura stow:** cada carpeta de primer nivel es un paquete stow. No copiar `.git` ni `README.md`.
- **No instalar paquetes AUR sin preguntar:** `stow` y `fastfetch`/`starship` están en `extra`.
- **Imágenes fastfetch:** añadir en `~/Imágenes/fastfetch-images/*.jpg` y copiar a `fastfetch/.config/fastfetch/assets/fastfetch-images/` para versionar. `config.jsonc` usa wildcard `*.jpg` (random cada ejecución, `kitty` protocol en Kitty, fallback texto en otros términos).
- **Vesktop fix:** necesita `LIBVA_DRIVER_NAME=iHD DRI_PRIME=0` + `--disable-gpu-sandbox` por bug `wayland is not compatible with Vulkan` en Electron+NVIDIA Wayland. El `.desktop` en `applications/` ya lo incluye.
- **Starship:** `palette` no es `ii` de inir, es custom Nord. Si reinstalas `inir`, respeta `~/.config/starship.toml`.

---

## 🔄 Actualizar

```bash
cd ~/dotfiles
git pull
./install.sh
```

---

## 📄 Licencia

MIT
