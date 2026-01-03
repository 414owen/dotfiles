#!/bin/sh

sudo pacman -S --needed base-devel git
if ! command -v paru &> /dev/null; then
  git clone https://aur.archlinux.org/paru.git
  cd paru
  makepkg -si
  cd ..
fi
paru -S --needed $(command cat packages)
