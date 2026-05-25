#!/bin/bash
# =============================================================================
#  dotfiles — bootstrap installer for CachyOS / Arch + Hyprland
#  Gaming + Programming + Minimalist
#
#  Usage:
#    chmod +x install.sh && ./install.sh
#
#  This will:
#    1. Install required packages
#    2. Symlink (stow) or copy dotfiles to ~/.config/
#    3. Enable services
# =============================================================================

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

log()  { echo -e "${GREEN}[✓]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }
err()  { echo -e "${RED}[✗]${NC} $1"; }

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# ─── Detectar distro ──────────────────────────────────────────────────────
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO="$ID"
else
    DISTRO="unknown"
fi

echo -e "${CYAN}"
echo "  ╔═══════════════════════════════════════════╗"
echo "  ║     dotfiles — Hyprland Setup             ║"
echo "  ║     $DISTRO detected                      ║"
echo "  ╚═══════════════════════════════════════════╝"
echo -e "${NC}"

# ─── Paquetes ──────────────────────────────────────────────────────────────
BASE_PKGS=(
    hyprland hyprlock hypridle
    xdg-desktop-portal-hyprland
    waybar rofi-wayland
    kitty
    dunst libnotify
    thunar thunar-archive-plugin
    polkit-kde-agent
    grimblast-git swappy
    cliphist wl-clipboard
    swww
    pipewire wireplumber pavucontrol
    brightnessctl
    ttf-jetbrains-mono-nerd noto-fonts-emoji
    firewalld
)

NVIDIA_PKGS=(
    nvidia-dkms nvidia-utils nvidia-settings
    libva-nvidia-driver-git
    nvidia-prime
)

GAMING_PKGS=(
    gamemode lib32-gamemode mangohud
    steam
)

DEV_PKGS=(
    git base-devel
    neovim
    python python-pip
    nodejs npm
    lazygit
    btop
)

THEME_PKGS=(
    catppuccin-gtk-theme-mocha papirus-icon-theme
)

# ─── Install con pacman ────────────────────────────────────────────────────
install_pacman() {
    warn "Instalando paquetes base..."
    sudo pacman -S --needed "${BASE_PKGS[@]}" "${DEV_PKGS[@]}" "${THEME_PKGS[@]}" || true

    warn "Instalando paquetes NVIDIA..."
    sudo pacman -S --needed "${NVIDIA_PKGS[@]}" || true

    warn "Instalando paquetes gaming..."
    sudo pacman -S --needed "${GAMING_PKGS[@]}" || true
}

# ─── dotfiles: symlink con stow o copia directa ──────────────────────────
install_dotfiles() {
    if command -v stow &> /dev/null; then
        log "Instalando dotfiles con GNU Stow..."
        for dir in .config/hypr .config/waybar .config/rofi .config/dunst .config/kitty scripts; do
            if [ -d "$DOTFILES_DIR/$dir" ]; then
                stow -t "$HOME" --restow -d "$DOTFILES_DIR" "$dir" 2>/dev/null || \
                    stow -t "$HOME" -d "$DOTFILES_DIR" "$dir"
                log "Symlinked: $dir → $HOME/$dir"
            fi
        done
    else
        warn "GNU Stow no instalado. Instalándolo..."
        sudo pacman -S --needed stow
        install_dotfiles
    fi
}

# ─── Servicios ──────────────────────────────────────────────────────────────
enable_services() {
    warn "Habilitando servicios..."
    systemctl --user enable --now pipewire wireplumber 2>/dev/null || true
    sudo systemctl enable --now firewalld 2>/dev/null || true
    log "Servicios iniciados"
}

# ─── Post-install ──────────────────────────────────────────────────────────
post_install() {
    echo ""
    echo -e "${CYAN}  ╔═══════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}  ║  Instalación completada                       ║${NC}"
    echo -e "${CYAN}  ╚═══════════════════════════════════════════════╝${NC}"
    echo ""
    echo "  🔑 Atajos principales:"
    echo "     SUPER + Enter   → Kitty"
    echo "     SUPER + D       → Rofi (apps)"
    echo "     SUPER + Q       → Cerrar ventana"
    echo "     SUPER + 1-9     → Workspaces"
    echo "     SUPER + F       → Fullscreen"
    echo "     SUPER + V       → Float toggle"
    echo "     SUPER + S       → Scratchpad"
    echo "     Print           → Screenshot (área)"
    echo "     SUPER + Escape  → Power menu"
    echo ""
    echo "  🎮 Gaming:"
    echo "     prime-run <comando>  → ejecuta con GPU dedicada"
    echo "     mangohud <app>       → overlay en juegos"
    echo "     gamemoderun <app>    → optimiza CPU/GPU"
    echo ""
    echo "  📁 Tus dotfiles están en: $DOTFILES_DIR"
    echo "  📝 Tus cambios personales: ~/.config/hypr/user.conf"
    echo ""
    echo "  ⚠️  Si es primera vez, REINICIA sesión y selecciona Hyprland."
    echo ""
}

# ─── Main ──────────────────────────────────────────────────────────────────
main() {
    echo ""
    warn "Este script instalará paquetes y configurará tu sistema."
    echo "  ¿Quieres continuar? (s/N)"
    read -r confirm
    if [[ ! "$confirm" =~ ^[sS]$ ]]; then
        err "Instalación cancelada."
        exit 1
    fi

    install_pacman
    install_dotfiles
    enable_services
    post_install
}

main "$@"
