#!/usr/bin/env bash
set -euo pipefail

HOSTNAME_TARGET="seabass-bridge"
INSTALL_ROOT="/opt/seabass-bridge"
STATE_DIR="/var/lib/seabass-bridge"
LOG_DIR="/var/log/seabass-bridge"

if [ "$(id -u)" -ne 0 ]; then
  echo "Run with sudo: sudo ./bootstrap.sh" >&2
  exit 1
fi

echo "[1/7] Setting hostname..."
hostnamectl set-hostname "$HOSTNAME_TARGET"

if grep -qE '^127\.0\.1\.1[[:space:]]+' /etc/hosts; then
  sed -i -E "s/^127\.0\.1\.1[[:space:]]+.*/127.0.1.1\t$HOSTNAME_TARGET/" /etc/hosts
else
  printf '127.0.1.1\t%s\n' "$HOSTNAME_TARGET" >> /etc/hosts
fi

echo "[2/7] Updating package metadata..."
apt-get update

echo "[3/7] Installing base packages..."
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  ca-certificates curl git jq openssh-server rsync tmux usbutils v4l-utils

echo "[4/7] Enabling SSH..."
systemctl enable --now ssh

echo "[5/7] Creating project directories..."
install -d -m 0755 "$INSTALL_ROOT" "$STATE_DIR" "$LOG_DIR"
rsync -a --delete --exclude '.git/' --exclude 'config/seabass.env' ./ "$INSTALL_ROOT/"

if [ ! -f "$INSTALL_ROOT/config/seabass.env" ]; then
  cp "$INSTALL_ROOT/config/seabass.env.example" "$INSTALL_ROOT/config/seabass.env"
fi

echo "[6/7] Installing systemd units..."
install -m 0644 "$INSTALL_ROOT/systemd/seabass-health.service" /etc/systemd/system/seabass-health.service
systemctl daemon-reload
systemctl enable --now seabass-health.service

echo "[7/7] Running diagnostics..."
"$INSTALL_ROOT/scripts/diagnostics.sh" || true

echo
echo "seabass-bridge bootstrap complete."
echo "Reboot recommended: sudo reboot"
