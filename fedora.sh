#!/usr/bin/env sh

sudo dnf copr enable atim/starship
sudo dnf install $(command cat packages)
# Install wild linker:
cargo install --locked --bin wild --git https://github.com/davidlattimore/wild.git wild
