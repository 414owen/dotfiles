#!/usr/bin/env sh

sudo xbps-install $(cat packages-void packages) || true

enable() {
  if [ ! -d /etc/runit/runsvdir/${i} ]; then
    sudo ln -sf /etc/runit/runsvdir/${i} /var/services
  fi
}

enable elogind
enable dbus
enable iwd

# These lines make firefox start really slowly...
sudo sd '^([a-z])' '# $1' /etc/resolv.conf
