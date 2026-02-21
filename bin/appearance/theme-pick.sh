#!/usr/bin/env bash

set -e

DOTFILES="$HOME/.dotfiles"
THEMES_DIR="$DOTFILES/themes"
CONFIG_DIR="$DOTFILES/config"

# Escolher tema
theme=$(ls "$THEMES_DIR" | rofi -dmenu)

[ -z "$theme" ] && exit 0

THEME_PATH="$THEMES_DIR/$theme"

if [ ! -d "$THEME_PATH" ]; then
    notify-send "Erro" "Tema não encontrado"
    exit 1
fi

# Percorre todos os arquivos do tema
find "$THEME_PATH" -type f | while read -r file; do
    # Caminho relativo dentro do tema
    relative="${file#$THEME_PATH/}"

    if [[ "$relative" == wallpapers/* ]]; then
        continue
    fi

    target="$CONFIG_DIR/$relative"

    # Remove arquivo anterior (se existir)
    [ -e "$target" ] && rm -f "$target"

    # Cria diretório se necessário
    mkdir -p "$(dirname "$target")"

    # Cria symlink
    ln -s "$file" "$target"
done

ln -sf "$THEME_PATH/wallpapers" "$DOTFILES"


# Reload Hyprland
hyprctl reload

WALL_TOGGLE="$HOME/.local/bin/toggle-wallpaper.sh"
[ -x "$WALL_TOGGLE" ] && "$WALL_TOGGLE" next

notify-send "Tema $theme aplicado."
