#!/usr/bin/env sh

sudo xbps-install -f $(grep -h -v -e '^sway-contrib$' -e '^waybar$' packages packages-void) || true

enable() {
  if [ ! -e /var/service/$1 ]; then
    sudo ln -s /etc/sv/$1 /var/service/$1
  fi
}

enable elogind
enable dbus
