# Validación de River en CachyOS

Este documento describe el siguiente paso después de instalar CachyOS y clonar estos dotfiles. La prueba debe hacerse desde una sesión gráfica de River, con una segunda TTY disponible (`Ctrl+Alt+F3`) por si la sesión falla.

## 1. Antes de ejecutar el instalador

Desde una TTY o terminal:

```bash
sudo pacman -Syu
lspci -k | grep -A 3 -E 'VGA|3D|Display'
river --version
```

En un portátil con RTX 3060 Mobile comprueba qué GPU y kernel está usando el sistema. No instales manualmente paquetes NVIDIA si `chwd` aún no ha detectado el hardware.

## 2. Instalar la configuración

```bash
git clone https://github.com/PabloJustDevelops/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

El instalador:

- Pide confirmación antes de cambiar el sistema.
- Instala paquetes de River, Waybar, swww, audio, capturas, bloqueo y monitores.
- Ejecuta `sudo chwd -a` únicamente si detecta NVIDIA.
- Instala las utilidades NVIDIA y soporte de 32 bits.
- Enlaza los archivos de configuración con GNU Stow.

## 3. Primera sesión

Cierra sesión y selecciona `River` en el gestor de sesiones. Si River no aparece, inicia una sesión desde TTY para revisar el error en lugar de modificar archivos a ciegas.

Prueba en este orden:

1. `Super+Enter`: Kitty.
2. `Super+D`: Rofi.
3. `Super+1` y `Super+2`: cambio de tag.
4. `Super+Shift+1`: mover una ventana.
5. `Super+V`: flotante.
6. `Super+F`: pantalla completa.
7. `Print`: captura con grim/slurp/swappy.
8. `Super+Escape`: menú de energía; no pulses una acción destructiva durante la prueba.

## 4. Comprobaciones de servicios

```bash
pgrep -a river
pgrep -a waybar
pgrep -a dunst
pgrep -a swww
pgrep -a kanshi
pgrep -a swayidle
systemctl --user --no-pager status pipewire wireplumber
```

Comprueba también:

```bash
wpctl status
swww query
```

Si no quieres bloqueo automático durante la configuración inicial, comenta temporalmente el bloque de `swayidle` en `~/.config/river/autostart`.

## 5. Comprobación NVIDIA

```bash
nvidia-smi
prime-run glxinfo -B
```

Si `prime-run` no existe, no fuerces un script todavía: revisa el perfil que instaló `chwd` y los paquetes del kernel. En un portátil híbrido, el escritorio puede funcionar con la iGPU y los juegos se pueden lanzar con `prime-run`.

## 6. Monitores

Lista las salidas disponibles:

```bash
kanshictl list
```

Edita `~/.config/kanshi/config` y reemplaza los nombres de ejemplo por los nombres reales. Reinicia Kanshi después de cambiar el archivo.

## 7. Prueba de juegos

```bash
gamemoderun mangohud prime-run <juego>
```

Para Steam, configura por juego:

```text
prime-run gamemoderun mangohud %command%
```

Prueba primero un juego poco importante y comprueba que el escritorio sigue respondiendo antes de probar juegos más pesados.

## 8. Uso de un agente para probarlo

Un agente local o remoto puede ayudar a hacer comprobaciones **no destructivas**, pero no debe recibir automáticamente permisos para ejecutar `sudo`, borrar archivos, reiniciar, cambiar drivers ni editar el repositorio sin revisión.

Dale una tarea con este alcance:

```text
Prueba esta instalación de River en CachyOS de forma no destructiva.
Puedes ejecutar comandos de lectura y comprobar versiones, procesos, Wayland,
Waybar, audio, swww, kanshi, swayidle, NVIDIA y atajos que no sean destructivos.
No uses sudo, no instales ni borres paquetes, no reinicies, no cambies drivers,
no modifiques archivos ni ejecutes apagado/suspensión. Para cada fallo indica:
comando, salida, impacto y corrección propuesta. Pide confirmación antes de
cualquier cambio.
```

El agente debe conservar un informe con:

- Hardware y kernel detectados.
- Perfil NVIDIA seleccionado por `chwd`.
- Estado de River, Waybar, Dunst, PipeWire y swww.
- Salidas de monitor detectadas por Kanshi.
- Resultado de los atajos probados.
- Problemas reproducibles y solución propuesta.

## 9. Recuperación

Si la sesión gráfica no inicia:

1. Cambia a una TTY con `Ctrl+Alt+F3`.
2. Inicia sesión.
3. Comprueba los logs:

```bash
journalctl --user -b --no-pager | tail -200
```

4. Renombra temporalmente la configuración de River para recuperar una sesión limpia:

```bash
mv ~/.config/river ~/.config/river.backup
```

No borres el backup hasta confirmar que todo funciona.
