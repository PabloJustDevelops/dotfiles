# river + nvidia vars para fish
set -x XDG_CURRENT_DESKTOP river
set -x XDG_SESSION_TYPE wayland
set -x MOZ_ENABLE_WAYLAND 1
set -x QT_QPA_PLATFORM wayland
set -x SDL_VIDEODRIVER wayland
set -x GBM_BACKEND nvidia-drm
set -x __GLX_VENDOR_LIBRARY_NAME nvidia
set -x LIBVA_DRIVER_NAME nvidia
set -x WLR_NO_HARDWARE_CURSORS 1
set -x NVD_BACKEND direct
set -x LIBSEAT_BACKEND logind
