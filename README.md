# dotfiles — River (gaming + desarrollo + minimalista)

Configuración para **River**, pensada para CachyOS / Arch Linux, con Waybar, Rofi, Kitty, Dunst, PipeWire y herramientas de desarrollo.

## Estructura

```text
.config/
├── river/
│   ├── init       # Configuración principal y atajos
│   ├── autostart  # Variables Wayland, wallpaper y polkit
│   └── powermenu  # Menú de apagado/reinicio/suspensión
├── waybar/
│   ├── config.jsonc
│   └── style.css
├── rofi/
├── dunst/
└── kitty/
scripts/
```

River es un compositor de Wayland basado en etiquetas (tags), no en workspaces de River. La configuración usa nueve tags equivalentes a los workspaces 1–9.

## Atajos principales

| Tecla | Acción |
|---|---|
| `SUPER + Enter` | Abrir Kitty |
| `SUPER + D` | Lanzador Rofi |
| `SUPER + Q` | Cerrar ventana |
| `SUPER + 1-9` | Cambiar tag |
| `SUPER + SHIFT + 1-9` | Mover ventana al tag |
| `SUPER + H/J/K/L` | Cambiar foco |
| `SUPER + SHIFT + H/J/K/L` | Mover ventana |
| `SUPER + F` | Pantalla completa |
| `SUPER + V` | Alternar flotante |
| `SUPER + R` | Modo redimensionar |
| `SUPER + Escape` | Menú de energía |
| `Print` | Captura de área |
| `SUPER + SHIFT + E` | Salir de River |

## Instalación en Arch/CachyOS

```bash
git clone https://github.com/PabloJustDevelops/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

El instalador pide confirmación, instala River y las herramientas auxiliares mediante `pacman`, y enlaza `.config` con GNU Stow cuando está disponible. Después cierra sesión y selecciona **River** en tu gestor de sesiones.

## Wallpaper

Para usar un wallpaper con `swww`, crea `~/.config/river/wallpaper` con la ruta absoluta de una imagen. El autostart solo la usa si el archivo existe.

## NVIDIA

River funciona con Wayland, pero la configuración específica de NVIDIA depende del kernel, driver y equipo. El instalador no fuerza paquetes NVIDIA ni variables experimentales: configúralos según tu hardware para evitar romper otros compositores.

## Personalización

Edita `~/.config/river/init` para atajos y reglas. Puedes cambiar el terminal y lanzador al principio del archivo. Edita `~/.config/river/autostart` para servicios de sesión.

## Licencia

Configuración personal. Adapta los paquetes y comandos a tu hardware y distribución.
