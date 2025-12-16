#!/usr/bin/env sh

sudo xbps-install -f $(cat packages-void packages) || true

enable() {
  if [ ! -d /etc/runit/runsvdir/${i} ]; then
    sudo ln -sf /etc/runit/runsvdir/${i} /var/services
  fi
}

enable elogind
enable dbus
