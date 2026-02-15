#!/usr/bin/env bash
if command -v hyprshutdown >/dev/null 2>&1; then
  hyprshutdown
else
  hyprctl dispatch exit
fi
