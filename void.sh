#!/usr/bin/env sh

sudo xbps-install $(cat packages-void packages) || true

enable() {
  sudo ln -sf /etc/sv/${i} /var/services
}

enable elogind
enable dbus
