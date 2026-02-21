#!/usr/bin/env bash

declare -A texts
declare -A scripts

texts[screenshot]="󰄀 Screenshot"
texts[pacman]=" Pacman"
texts[aur]=" AUR"
texts[remove]=" Remove"
texts[style]="󱠓 Style"
texts[power]="󰐦 Power menu"

scripts[screenshot]="$HOME/.local/bin/screenshot.sh"
scripts[pacman]="uwsm-app -- kitty --class 'pop-up' -e $HOME/.local/bin/pkg-install.sh"
scripts[aur]="uwsm-app -- kitty --class 'pop-up' -e $HOME/.local/bin/pkg-aur-install.sh"
scripts[remove]="uwsm-app -- kitty --class 'pop-up' -e $HOME/.local/bin/pkg-remove.sh"
scripts[power]="uwsm-app -- rofi -show power-menu -modi power-menu:$HOME/.local/bin/rofi-power-menu.sh"

# -------- STYLE SUBMENU --------
style_menu() {
    declare -A style_texts
    declare -A style_scripts

    style_texts[toggle]="󰸉 Toggle Wallpaper"
    style_texts[theme]=" Theme Pick"

    style_scripts[toggle]="$HOME/.local/bin/toggle-wallpaper.sh"
    style_scripts[theme]="$HOME/.local/bin/theme-pick.sh"

    submenu=""
    for key in "${!style_texts[@]}"; do
        submenu+="${style_texts[$key]}\n"
    done

    style_choice=$(echo -e "$submenu" | rofi -dmenu -i -p "Style")

    for key in "${!style_texts[@]}"; do
        if [[ "${style_texts[$key]}" == "$style_choice" ]]; then
            eval "${style_scripts[$key]}"
            break
        fi
    done
}
# --------------------------------

# Criar menu principal
menu=""
for key in "${!texts[@]}"; do
    menu+="${texts[$key]}\n"
done

choice=$(echo -e "$menu" | rofi -dmenu -i)

for key in "${!texts[@]}"; do
    if [[ "${texts[$key]}" == "$choice" ]]; then
        if [[ "$key" == "style" ]]; then
            style_menu
        else
            eval "${scripts[$key]}"
        fi
        break
    fi
done
