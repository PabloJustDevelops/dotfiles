#!/bin/bash
# River dotfiles installer for Arch Linux / CachyOS.
set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
log() { echo -e "${GREEN}[✓]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }
err() { echo -e "${RED}[✗]${NC} $1"; }
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ -f /etc/os-release ]; then . /etc/os-release; else ID=unknown; fi
if [ "${ID:-unknown}" != arch ] && [ "${ID:-unknown}" != cachyos ]; then
    warn "Este instalador está pensado para Arch Linux/CachyOS; distro detectada: ${ID:-unknown}."
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
    brightnessctl
    ttf-jetbrains-mono-nerd noto-fonts-emoji
    polkit-kde-agent
    git base-devel stow
    neovim python python-pip nodejs npm lazygit btop
    gamemode mangohud steam
)

install_packages() {
    warn "Instalando paquetes para River..."
    sudo pacman -Syu --needed "${BASE_PKGS[@]}"
}

install_dotfiles() {
    if command -v stow >/dev/null 2>&1; then
        stow -t "$HOME" --restow -d "$DOTFILES_DIR" .config scripts
    else
        mkdir -p "$HOME/.config"
        cp -a "$DOTFILES_DIR/.config/." "$HOME/.config/"
        cp -a "$DOTFILES_DIR/scripts/." "$HOME/.local/bin/" 2>/dev/null || true
    fi
    chmod +x "$DOTFILES_DIR/.config/river/init" "$DOTFILES_DIR/.config/river/autostart" "$DOTFILES_DIR/.config/river/powermenu"
    log "Configuración de River instalada"
}

enable_services() {
    systemctl --user enable --now pipewire wireplumber 2>/dev/null || true
    log "Audio PipeWire habilitado"
}

cat <<EOF
${CYAN}River dotfiles${NC}

Se instalarán paquetes y se enlazarán los dotfiles en:
  $HOME/.config/river
  $HOME/.config/waybar
  $HOME/.config/kitty

Atajos principales:
  SUPER + Enter       Kitty
  SUPER + D           Rofi
  SUPER + Q           Cerrar ventana
  SUPER + 1..9        Cambiar tag
  SUPER + Shift + 1..9 Mover ventana a tag
  SUPER + H/J/K/L     Enfocar
  SUPER + Shift + H/J/K/L Mover ventana
  SUPER + F           Pantalla completa
  SUPER + V           Flotar
  SUPER + R           Modo redimensionar
  SUPER + Escape      Menú de energía
  Print               Captura de área
EOF
read -r -p '¿Continuar? (s/N) ' confirm
[[ "$confirm" =~ ^[sS]$ ]] || { err 'Instalación cancelada.'; exit 1; }
install_packages
install_dotfiles
enable_services
log 'Instalación completada. Cierra sesión y selecciona River en tu gestor de sesiones.'
