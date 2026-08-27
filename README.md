# dotfiles — River (CachyOS + gaming + desarrollo)

Configuración personal para **River** en CachyOS/Arch Linux, con Waybar, Rofi, Kitty, Dunst, PipeWire y herramientas de desarrollo.

## Componentes

```text
river + rivertile
waybar + swww
rofi-wayland + kitty + dunst
kanshi + swaylock + swayidle + wlogout
xdg-desktop-portal-wlr + polkit-gnome
pipewire + wireplumber + pavucontrol
grim + slurp + swappy + wl-clipboard + cliphist
```

River usa tags en lugar de workspaces. La configuración proporciona nueve tags equivalentes a los espacios 1–9.

## Instalación

```bash
git clone https://github.com/PabloJustDevelops/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

El instalador está pensado para CachyOS. Pide confirmación, instala los paquetes mediante `pacman`, enlaza `.config` con GNU Stow y habilita PipeWire. Después cierra sesión y selecciona River en el gestor de sesiones.

## NVIDIA RTX 3060 Mobile / Optimus

Si se detecta una GPU NVIDIA, el instalador instala `chwd` y ejecuta:

```bash
sudo chwd -a
```

CachyOS selecciona así el perfil de driver compatible con el kernel instalado. Después instala las utilidades NVIDIA y soporte de 32 bits. No se fuerza `nvidia-open` ni una variante DKMS concreta, porque CachyOS puede utilizar distintos kernels y perfiles.

En un portátil híbrido, lo recomendable es ejecutar River en la iGPU y reservar la RTX para juegos o aplicaciones pesadas:

```bash
prime-run steam
prime-run <programa>
nvidia-smi
```

Si `prime-run` no aparece después de `chwd`, revisa el perfil instalado y el paquete `nvidia-prime` antes de iniciar juegos.

## Wallpaper con transiciones

Crea `~/.config/river/wallpaper` con la ruta absoluta a una imagen. El autostart iniciará `swww` y aplicará una transición `wipe`:

```bash
printf '%s\n' "$HOME/Pictures/wallpaper.png" > ~/.config/river/wallpaper
```

## Atajos

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
| `SUPER + V` | Flotante |
| `SUPER + R` | Redimensionar |
| `SUPER + Escape` | Menú de energía |
| `Print` | Captura de área |
| `SUPER + SHIFT + E` | Salir de River |

## Monitores y bloqueo

Kanshi se inicia automáticamente si está instalado. Añade perfiles en `~/.config/kanshi/config` para portátil, dock y monitores externos. `swayidle` bloquea la sesión tras diez minutos y suspende tras quince, si `swaylock` está disponible.

## Notas

El instalador no configura el firewall ni modifica paquetes NVIDIA de forma fija. Eso evita romper instalaciones de CachyOS con kernels o perfiles distintos.
