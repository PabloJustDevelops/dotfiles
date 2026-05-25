#  dotfiles — Hyprland (gaming + dev + minimal)

Configuración personal de Hyprland para **CachyOS / Arch Linux** con **NVIDIA RTX 3060** en portátil.

Basado en ideas de JaKooLit, CachyOS, binnewbs y la comunidad de Hyprland.

##  Estructura

```
.config/
├── hypr/
│   ├── hyprland.conf      # Principal — sourcea los demás
│   ├── env.conf           # NVIDIA, Wayland, Qt/GTK
│   ├── input.conf         # Teclado (ES), touchpad
│   ├── keybinds.conf      # Atajos completos
│   ├── monitor.conf       # Monitores (portátil + dock)
│   ├── windowrules.conf   # Reglas para juegos, floats, etc
│   ├── animations.conf    # Animaciones ligeras
│   └── user.conf          # TUS cambios personales (no se toca)
├── waybar/
│   ├── config.jsonc       # Barra con GPU, RAM, vol, batería
│   └── style.css          # Catppuccin Mocha
├── rofi/
│   └── config.rasi        # App launcher + power menu
├── dunst/
│   └── dunstrc            # Notificaciones minimal
└── kitty/
    └── kitty.conf         # Terminal con tema Catppuccin
scripts/
├── gpu-info.sh            # Info GPU para waybar
└── rofi-power-menu.sh     # Apagar / reiniciar / suspender
```

##   Atajos principales

| Tecla | Acción |
|---|---|
| `SUPER + Enter` | Terminal (Kitty) |
| `SUPER + D` | App launcher (Rofi) |
| `SUPER + Q` | Cerrar ventana |
| `SUPER + 1-9` | Cambiar workspace |
| `SUPER + SHIFT + 1-9` | Mover ventana a workspace |
| `SUPER + F` | Fullscreen |
| `SUPER + V` | Toggle floating |
| `SUPER + S` | Scratchpad |
| `SUPER + CTRL + flechas` | Redimensionar ventana |
| `Print` | Screenshot (área) |
| `SUPER + Escape` | Power menu |

##   Gaming

```bash
# Ejecutar juego con GPU dedicada (si tienes Optimus híbrido)
prime-run steam

# Overlay de rendimiento (FPS, temps, uso)
mangohud %command%        # en opciones de lanzamiento de Steam
gamemoderun %command%     # optimiza CPU/GPU

# Monitorizar GPU
btop                      # terminal
watch -n1 nvidia-smi      # clásico
```

##   Instalación

```bash
# Clonar
git clone https://github.com/TU_USUARIO/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Ejecutar (instala paquetes + configura)
chmod +x install.sh
./install.sh

# O manual: solo los dotfiles
stow -t ~ .config/hypr .config/waybar .config/rofi .config/dunst .config/kitty scripts
```

Después reinicias sesión y seleccionas **Hyprland**.

##   Personalizar sin romper nada

Todos tus cambios van en `~/.config/hypr/user.conf`:

```conf
# Ejemplo: cambiar atajo de terminal
bind = SUPER, Return, exec, wezterm
```

Ese archivo se sourcea al final y nunca lo toca el instalador.

##   Créditos

- [JaKooLit / Arch-Hyprland](https://github.com/JaKooLit/Arch-Hyprland)
- [CachyOS](https://cachyos.org)
- [binnewbs / arch-hyprland](https://github.com/binnewbs/arch-hyprland)
- [Catppuccin](https://github.com/catppuccin)
