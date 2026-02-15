#!/usr/bin/env bash

kitty -e bash -c "
echo 'Atualizando repositórios oficiais...';
sudo pacman -Syu;

if command -v yay >/dev/null 2>&1; then
    echo '';
    echo 'Atualizando AUR (com revisão de PKGBUILD)...';
    yay -Sua --diffmenu --editmenu --cleanmenu;
fi

echo '';
read -p 'Pressione Enter para fechar...'
"
