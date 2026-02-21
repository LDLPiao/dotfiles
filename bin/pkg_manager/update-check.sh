#!/usr/bin/env bash

updates=$(checkupdates 2>/dev/null | wc -l)

if command -v yay >/dev/null 2>&1; then
    aur=$(yay -Qua 2>/dev/null | wc -l)
else
    aur=0
fi

total=$((updates + aur))

if [ "$total" -gt 0 ]; then
    echo "{\"text\":\"󰏖\",\"tooltip\":\"$total atualizações disponíveis\"}"
else
    echo ""
fi
