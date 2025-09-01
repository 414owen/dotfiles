#!/usr/bin/env bash

sudo dnf copr enable atim/starship
sudo dnf install $(command cat packages)
cargo install --locked --bin jj jj-cli

echo "Installing rpmfusion"
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
