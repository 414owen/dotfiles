#!/usr/bin/env sh

sudo dnf copr enable atim/starship
sudo dnf install $(command cat packages)
