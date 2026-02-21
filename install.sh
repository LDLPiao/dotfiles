#!/usr/bin/env bash

set -euo pipefail

### ==============================
### VARIÁVEIS
### ==============================

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACMAN_FILE="$DOTFILES_DIR/pacman.txt"
AUR_FILE="$DOTFILES_DIR/aur.txt"

CONFIG_DIR="$DOTFILES_DIR/config"
HOME_DIR="$DOTFILES_DIR/home"
BIN_DIR="$DOTFILES_DIR/bin"
WALLPAPER_DIR="$DOTFILES_DIR/wallpapers"

USER_BIN="$HOME/.local/bin"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +"%Y_%m_%d_%H%M%S")"

### ==============================
### FUNÇÕES UTILITÁRIAS
### ==============================

log() { echo -e "\033[1;32m[INFO]\033[0m $1"; }
warn() { echo -e "\033[1;33m[WARN]\033[0m $1"; }
error() { echo -e "\033[1;31m[ERRO]\033[0m $1"; }
command_exists() { command -v "$1" &> /dev/null; }

### ==============================
### SISTEMA
### ==============================

update_system() {
  log "Atualizando sistema..."
  sudo pacman -Syu --noconfirm
}

install_pacman_packages() {
  [[ -f "$PACMAN_FILE" ]] || { warn "Arquivo pacman não encontrado."; return; }
  log "Instalando pacotes do pacman..."
  sudo pacman -S --needed --noconfirm - < "$PACMAN_FILE"
}

install_yay() {
  if ! command_exists yay; then
    log "Instalando yay..."
    sudo pacman -S git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    pushd /tmp/yay > /dev/null
    makepkg -si --noconfirm
    popd > /dev/null
    rm -rf /tmp/yay
  else
    log "yay já instalado."
  fi
}

install_aur_packages() {
  [[ -f "$AUR_FILE" ]] || { warn "Arquivo aur não encontrado."; return; }
  log "Instalando pacotes AUR..."
  yay -S --needed --noconfirm - < "$AUR_FILE"
}

### ==============================
### DOTFILES
### ==============================

backup_if_exists() {
  local target="$1"
  mkdir -p "$BACKUP_DIR"

  if [[ -L "$target" ]]; then
    warn "Removendo symlink existente: $target"
    rm "$target"
  elif [[ -e "$target" ]]; then
    warn "Backup de $target"
    mv "$target" "$BACKUP_DIR/$(basename "$target")"
  fi
}

link_config() {
  [[ -d "$CONFIG_DIR" ]] || return
  log "Linkando ~/.config"
  mkdir -p "$HOME/.config"

  for item in "$CONFIG_DIR"/*; do
    target="$HOME/.config/$(basename "$item")"
    backup_if_exists "$target"
    ln -sf "$item" "$target"
  done
}

link_home() {
  [[ -d "$HOME_DIR" ]] || return
  log "Linkando arquivos do home"

  for item in "$HOME_DIR"/.*; do
    name=$(basename "$item")
    [[ "$name" == "." || "$name" == ".." ]] && continue
    target="$HOME/$name"
    backup_if_exists "$target"
    ln -sf "$item" "$target"
  done
}

# Link com estrutura de pastas
# install_bin() {
#   [[ -d "$BIN_DIR" ]] || return
#   log "Instalando scripts em /.local/bin"
#   mkdir -p "$USER_BIN"
#
#   for script in "$BIN_DIR"/*; do
#     target="$USER_BIN/$(basename "$script")"
#     ln -sf "$script" "$target"
#     chmod +x "$script"
#   done
# }

# Link 'flat'
install_bin() {
  [[ -d "$BIN_DIR" ]] || return
  log "Instalando scripts em /.local/bin"
  mkdir -p "$USER_BIN"

  find "$BIN_DIR" -type f | while read -r file; do
    name="$(basename $file)"
    target="$USER_BIN/$name"
    backup_if_exists "$target"
    ln -sf "$file" "$target"
  done
}

link_wallpapers() {
  [[ -d "$WALLPAPER_DIR" ]] || return
  target="$HOME/Pictures/wallpapers"
  log "Linkando ~/Imagens/wallpapers"
  mkdir -p "$target"
  backup_if_exists "$target"
  ln -sf "$WALLPAPER_DIR" "$target"
}

### ==============================
### PARSING DE ARGUMENTOS
### ==============================

INSTALL_SYSTEM=false
INSTALL_PACMAN=false
INSTALL_AUR=false
INSTALL_CONFIG=false
INSTALL_HOME=false
INSTALL_BIN=false
INSTALL_WALLPAPERS=false

if [[ $# -eq 0 ]]; then
  # Se nenhum argumento, instala tudo
  INSTALL_SYSTEM=true
  INSTALL_PACMAN=true
  INSTALL_AUR=true
  INSTALL_CONFIG=true
  INSTALL_HOME=true
  INSTALL_BIN=true
  INSTALL_WALLPAPERS=true
else
  for arg in "$@"; do
    case "$arg" in
      --system) INSTALL_SYSTEM=true ;;
      --pacman) INSTALL_PACMAN=true ;;
      --aur) INSTALL_AUR=true ;;
      --config) INSTALL_CONFIG=true ;;
      --home) INSTALL_HOME=true ;;
      --binaries) INSTALL_BIN=true ;;
      --wallpapers) INSTALL_WALLPAPERS=true ;;
      *) warn "Opção desconhecida: $arg" ;;
    esac
  done
fi

### ==============================
### EXECUÇÃO
### ==============================

main() {
  $INSTALL_SYSTEM && update_system
  $INSTALL_PACMAN && install_pacman_packages
  $INSTALL_AUR && install_yay && install_aur_packages
  $INSTALL_CONFIG && link_config
  $INSTALL_HOME && link_home
  $INSTALL_BIN && install_bin
  $INSTALL_WALLPAPERS && link_wallpapers

  log "Instalação concluída com sucesso."
}

main "$@"

