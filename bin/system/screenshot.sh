#!/usr/bin/env bash

OUTPUT_DIR="$HOME/Pictures/Screenshots"

declare -A texts
declare -A options
declare -A target

texts[window]="󱂬 Window"
texts[output]="󰍹 Output"
texts[region]="󰆟 Region"

options[window]="$HOME/.local/bin/hyprshot.sh -m window -o $OUTPUT_DIR"
options[output]="$HOME/.local/bin/hyprshot.sh -m output -o $OUTPUT_DIR"
options[region]="$HOME/.local/bin/hyprshot.sh -m region -o $OUTPUT_DIR"

menu=""
for key in "${!texts[@]}"; do
	menu+="${texts[$key]}\n"
done

choice=$(echo -e "$menu" | rofi -dmenu -i)

# Descobrir qual chave corresponde ao texto selecionado
for key in "${!texts[@]}"; do
    if [[ "${texts[$key]}" == "$choice" ]]; then
        eval "${options[$key]}"
        echo "${options[$key]}"
        break
    fi
done
