#!/bin/bash
# River dotfiles installer for CachyOS / Arch Linux.
set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
log() { echo -e "${GREEN}[OK]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }
err() { echo -e "${RED}[X]${NC} $1"; }
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ -f /etc/os-release ]; then . /etc/os-release; else ID=unknown; fi
case "${ID:-unknown}" in
    cachyos|arch) ;;
    *) warn "Pensado para CachyOS/Arch; distro detectada: ${ID:-unknown}." ;;
esac

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
    warn "Actualizando e instalando paquetes para River..."
    sudo pacman -Syu --needed "${BASE_PKGS[@]}"
}

install_nvidia() {
    if ! command -v lspci >/dev/null 2>&1 || ! lspci 2>/dev/null | grep -qi 'NVIDIA'; then
        warn "No se detectó una GPU NVIDIA; se omite la configuración NVIDIA."
        return
    fi

    warn "GPU NVIDIA detectada. Usando chwd para seleccionar el perfil compatible..."
    sudo pacman -S --needed chwd
    sudo chwd -a
    sudo pacman -S --needed nvidia-utils nvidia-settings lib32-nvidia-utils

    if command -v prime-run >/dev/null 2>&1; then
        log "prime-run disponible para ejecutar aplicaciones con la GPU dedicada"
    else
        warn "prime-run no está disponible; revisa el perfil Optimus seleccionado por chwd."
    fi
}

install_dotfiles() {
    stow -t "$HOME" --restow -d "$DOTFILES_DIR" .config scripts
    chmod +x "$DOTFILES_DIR/.config/river/init" "$DOTFILES_DIR/.config/river/autostart" "$DOTFILES_DIR/.config/river/powermenu"
    [ -f "$DOTFILES_DIR/scripts/rofi-power-menu.sh" ] && chmod +x "$DOTFILES_DIR/scripts/rofi-power-menu.sh"
    log "Configuración de River instalada"
}

enable_services() {
    systemctl --user enable --now pipewire wireplumber 2>/dev/null || true
    log "Audio PipeWire habilitado"
}

cat <<EOF
${CYAN}River dotfiles — CachyOS${NC}

Se instalarán River y sus componentes: Waybar, swww, kanshi,
swayidle/swaylock, wlogout, portal Wayland y utilidades de escritorio.
Si se detecta NVIDIA, CachyOS chwd seleccionará automáticamente el perfil.

Atajos principales:
  SUPER + Enter           Kitty
  SUPER + D               Rofi
  SUPER + Q               Cerrar ventana
  SUPER + 1..9            Cambiar tag
  SUPER + Shift + 1..9    Mover ventana a tag
  SUPER + H/J/K/L         Enfocar
  SUPER + Shift + H/J/K/L Mover ventana
  SUPER + F               Pantalla completa
  SUPER + V               Flotar
  SUPER + R               Redimensionar
  SUPER + Escape          Menú de energía
  Print                   Captura de área
EOF
read -r -p '¿Continuar? (s/N) ' confirm
[[ "$confirm" =~ ^[sS]$ ]] || { err 'Instalación cancelada.'; exit 1; }
install_packages
install_nvidia
install_dotfiles
enable_services
log 'Instalación completada. Cierra sesión y selecciona River.'
