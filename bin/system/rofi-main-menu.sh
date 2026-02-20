#!/usr/bin/env bash

declare -A texts
declare -A scripts

texts[screenshot]="󰄀 Screenshot"
texts[pacman]=" Pacman"
texts[aur]=" AUR"
texts[remove]=" Remove"
texts[theme]=" Themes"
texts[power]="󰐦 Power menu"

scripts[screenshot]="$HOME/.local/bin/screenshot"
scripts[pacman]="uwsm-app -- kitty --class 'pop-up' -e $HOME/.local/bin/pkg-install"
scripts[aur]="uwsm-app -- kitty --class 'pop-up' -e $HOME/.local/bin/pkg-aur-install"
scripts[remove]="uwsm-app -- kitty --class 'pop-up' -e $HOME/.local/bin/pkg-remove"
scripts[theme]="$HOME/.local/bin/theme-pick"
scripts[power]="uwsm-app -- rofi -show power-menu -modi power-menu:$HOME/.local/bin/rofi-power-menu"

# Criar menu com textos amigáveis
menu=""
for key in "${!texts[@]}"; do
    menu+="${texts[$key]}\n"
done

choice=$(echo -e "$menu" | rofi -dmenu -i)

# Descobrir qual chave corresponde ao texto selecionado
for key in "${!texts[@]}"; do
    if [[ "${texts[$key]}" == "$choice" ]]; then
        eval "${scripts[$key]}"
        echo "${scripts[$key]}"
        break
    fi
done
