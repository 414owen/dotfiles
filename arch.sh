#!/bin/sh

sudo pacman -S --needed base-devel git rustup asahi-audio
if ! command -v paru &> /dev/null; then
  rustup toolchain install nightly
fi
if ! command -v paru &> /dev/null; then
  git clone https://aur.archlinux.org/paru.git
  cd paru
  makepkg -si
  cd ..
fi
paru -S --needed $(command cat packages) pipewire-pulse otf-font-awesome
