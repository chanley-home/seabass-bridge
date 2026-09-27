#!/usr/bin/env bash
set -u

section() { printf '\n=== %s ===\n' "$1"; }

section "Identity"
printf 'Hostname: %s\n' "$(hostname)"
printf 'Kernel:   %s\n' "$(uname -srmo)"

section "OS"
if [ -r /etc/os-release ]; then
  grep -E '^(PRETTY_NAME|VERSION_ID)=' /etc/os-release || true
fi

section "Network"
ip -brief address 2>/dev/null || true
printf '\nDefault route:\n'
ip route show default 2>/dev/null || true

section "USB"
lsusb 2>/dev/null || true

section "Video devices"
v4l2-ctl --list-devices 2>/dev/null || echo "No V4L2 camera detected."

section "Services"
systemctl --no-pager --full status ssh.service 2>/dev/null | sed -n '1,8p' || true
systemctl --no-pager --full status seabass-health.service 2>/dev/null | sed -n '1,8p' || true

section "Storage"
df -h / || true

section "Temperature"
if command -v vcgencmd >/dev/null 2>&1; then
  vcgencmd measure_temp || true
elif [ -r /sys/class/thermal/thermal_zone0/temp ]; then
  awk '{printf "%.1f C\n", $1/1000}' /sys/class/thermal/thermal_zone0/temp
fi
