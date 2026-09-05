# dotfiles — Niri + fastfetch Impr Nord + Starship Dune

Configuración personal para **CachyOS / Niri** con lo configurado hoy.

## Contenido (stow)

```
fastfetch/.config/fastfetch/  # Impr Dune → Nord monochrome, logo random kitty (fastfetch-images/*.jpg)
starship/.config/starship.toml # Barra custom 1 línea Dune ámbar → Nord
fish/.config/fish/            # fish + fastfetch inicial + fnm
zsh/.zshrc                    # zsh + fastfetch inicial
niri/.config/niri/            # Niri compositor (config.kdl + config.d/)
vesktop/.config/vesktop/      # Vesktop fix VAAPI (LIBVA_DRIVER_NAME=iHD)
applications/.local/share/applications/vesktop.desktop # Vesktop launcher fix
```

Imágenes fastfetch en `fastfetch/.config/fastfetch/assets/fastfetch-images/` (11 imágenes Gran Turismo/JDM, random).

## Instalación

```bash
git clone https://github.com/PabloJustDevelops/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

Requiere `stow`, `fastfetch`, `starship`, `fish`, `kitty`.
