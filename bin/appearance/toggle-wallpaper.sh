#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
INTERVAL=60
STATE_FILE="$HOME/.cache/wallpaper_index"
PID_FILE="$HOME/.cache/wallpaper_cycle.pid"

mkdir -p "$HOME/.cache"

mapfile -t WALLPAPERS < <(ls "$WALLPAPER_DIR" 2>/dev/null | sort -V)
TOTAL=${#WALLPAPERS[@]}

if [[ $TOTAL -eq 0 ]]; then
    echo "Nenhum wallpaper encontrado."
    exit 1
fi

# Inicializa índice
if [[ ! -f "$STATE_FILE" ]]; then
    echo 0 > "$STATE_FILE"
fi

INDEX=$(cat "$STATE_FILE")

set_wallpaper() {
    FILE="${WALLPAPER_DIR}/${WALLPAPERS[$INDEX]}"
    awww img "$FILE" --transition-type random --transition-duration 1
    echo "$INDEX" > "$STATE_FILE"
}

next_wallpaper() {
    INDEX=$(( (INDEX + 1) % TOTAL ))
    set_wallpaper
}

prev_wallpaper() {
    INDEX=$(( (INDEX - 1 + TOTAL) % TOTAL ))
    set_wallpaper
}

is_running() {
    [[ -f "$PID_FILE" ]] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null
}

start_cycle() {
    if is_running; then
        echo "Cycle já está rodando (PID $(cat $PID_FILE))"
        exit 1
    fi

    (
        while true; do
            next_wallpaper
            sleep "$INTERVAL"
        done
    ) &

    echo $! > "$PID_FILE"
    echo "Cycle iniciado (PID $!)"
}

stop_cycle() {
    if is_running; then
        kill "$(cat "$PID_FILE")"
        rm -f "$PID_FILE"
        echo "Cycle parado."
    else
        echo "Cycle não está rodando."
    fi
}

status_cycle() {
    if is_running; then
        echo "Cycle rodando (PID $(cat $PID_FILE))"
    else
        echo "Cycle parado."
    fi
}

run_menu() {
    declare -A texts
    declare -A func

    texts[next]="󰙢 Next wallpaper"
    texts[prev]="󰙤 Previous wallpaper"
    texts[start]=" Start cycle process"
    texts[stop]=" Stop cycle process"

    func[next]=next_wallpaper
    func[prev]=prev_wallpaper
    func[start]=start_cycle
    func[stop]=stop_cycle

    options=(start stop next prev)

    submenu=""
    for key in "${options[@]}"; do
        submenu+="${texts[$key]}\n"
    done

    choice=$(echo -e "$submenu" | rofi -dmenu -i)

    for key in "${!texts[@]}"; do
        if [[ "${texts[$key]}" == "$choice" ]]; then
            eval "${func[$key]}"
            break 
        fi
    done
}

case "$1" in
    next)
        next_wallpaper
        ;;
    prev)
        prev_wallpaper
        ;;
    start)
        start_cycle
        ;;
    stop)
        stop_cycle
        ;;
    status)
        status_cycle
        ;;
    help)
        echo "Uso: $0 {next|prev|start|stop|status}"
        ;;
    *)
        run_menu
        exit 1
        ;;
esac
