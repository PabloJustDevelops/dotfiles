source /usr/share/cachyos-zsh-config/cachyos-config.zsh

# iNiR launcher PATH
case ":$PATH:" in
  *:"/home/pablorg/.local/bin":*) ;;
  *) export PATH="/home/pablorg/.local/bin:$PATH" ;;
esac
# end iNiR launcher PATH


# iNiR environment
export INIR_VENV="/home/pablorg/.local/state/quickshell/.venv"
export ILLOGICAL_IMPULSE_VIRTUAL_ENV="$INIR_VENV"
# Apply terminal color sequences (Material You from wallpaper)
if [ -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt ]; then
  cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
fi
# Starship prompt (fish is wired via config.fish; zsh needs its own init)
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi
# Fetch inicial
if command -v fastfetch >/dev/null 2>&1; then
  fastfetch
fi
# end iNiR
