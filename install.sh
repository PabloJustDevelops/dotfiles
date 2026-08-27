#!/bin/bash
# River dotfiles installer for Arch Linux / CachyOS.
set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
log() { echo -e "${GREEN}[OK]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }
err() { echo -e "${RED}[X]${NC} $1"; }
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ -f /etc/os-release ]; then . /etc/os-release; else ID=unknown; fi
if [ "${ID:-unknown}" != arch ] && [ "${ID:-unknown}" != cachyos ]; then
    warn "Pensado para Arch Linux/CachyOS; distro detectada: ${ID:-unknown}."
fi

BASE_PKGS=(
    river rivercarro
    waybar rofi-wayland kitty
    dunst libnotify
    thunar thunar-archive-plugin
    grim slurp swappy
    wl-clipboard cliphist
    swww
    pipewire wireplumber pavucontrol
    brightnessctl kanshi swaylock swayidle wlogout
    xdg-desktop-portal-wlr
    polkit-gnome
    git base-devel stow
    neovim python python-pip nodejs npm lazygit btop
    gamemode mangohud gamescope steam
)

install_packages() {
    warn "Instalando paquetes para River..."
    sudo pacman -Syu --needed "${BASE_PKGS[@]}"
}

install_nvidia() {
    if ! lspci 2>/dev/null | grep -qi 'NVIDIA'; then
        warn "No se detectó una GPU NVIDIA mediante lspci; se omiten los drivers."
        return
    fi
    warn "GPU NVIDIA detectada. Instalando el driver recomendado para kernel estándar..."
    # The package follows the kernel installed on the target machine. For a custom
    # kernel, install the matching nvidia-dkms package manually instead.
    sudo pacman -S --needed nvidia-open nvidia-utils nvidia-settings lib32-nvidia-utils
    warn "Si usas un kernel custom, sustituye nvidia-open por nvidia-dkms y su módulo correspondiente."
}

install_dotfiles() {
    stow -t "$HOME" --restow -d "$DOTFILES_DIR" .config scripts
    chmod +x "$DOTFILES_DIR/.config/river/init" "$DOTFILES_DIR/.config/river/autostart" "$DOTFILES_DIR/.config/river/powermenu"
    log "Configuración de River instalada"
}

enable_services() {
    systemctl --user enable --now pipewire wireplumber 2>/dev/null || true
    log "Audio PipeWire habilitado"
}

cat <<EOF
${CYAN}River dotfiles${NC}

Se instalarán River, Waybar, swww, kanshi, swayidle/swaylock,
wlogout, xdg-desktop-portal-wlr y las herramientas de escritorio.
También se detectará NVIDIA y se instalará el paquete recomendado.

Atajos principales:
  SUPER + Enter          Kitty
  SUPER + D              Rofi
  SUPER + Q              Cerrar ventana
  SUPER + 1..9           Cambiar tag
  SUPER + Shift + 1..9   Mover ventana a tag
  SUPER + H/J/K/L        Enfocar
  SUPER + Shift + H/J/K/L Mover ventana
  SUPER + F              Pantalla completa
  SUPER + V              Flotar
  SUPER + R              Redimensionar
  SUPER + Escape         Menú de energía
  Print                  Captura de área
EOF
read -r -p '¿Continuar? (s/N) ' confirm
[[ "$confirm" =~ ^[sS]$ ]] || { err 'Instalación cancelada.'; exit 1; }
install_packages
install_nvidia
install_dotfiles
enable_services
log 'Instalación completada. Cierra sesión y selecciona River.'
