#!/usr/bin/env bash
set -euo pipefail

echo "== Arch profile post-check =="

echo "[1] Service state"
for svc in NetworkManager sddm bluetooth docker libvirtd; do
  if systemctl is-enabled "${svc}" >/dev/null 2>&1; then
    echo "OK: ${svc} enabled"
  else
    echo "WARN: ${svc} not enabled"
  fi
done

echo "[2] Session binaries"
for bin in niri waybar rofi fuzzel dunst swaybg; do
  if command -v "${bin}" >/dev/null 2>&1; then
    echo "OK: ${bin} found"
  else
    echo "WARN: ${bin} missing"
  fi
done

echo "[3] Config paths"
for path in \
  "$HOME/.config/niri/config.kdl" \
  "$HOME/.config/waybar/config.jsonc" \
  "$HOME/.config/fuzzel/fuzzel.ini" \
  "$HOME/.config/mpv/mpv.conf" \
  "$HOME/.config/ranger/rc.conf" \
  "$HOME/.config/nvim/init.lua"; do
  if [[ -e "${path}" ]]; then
    echo "OK: ${path}"
  else
    echo "WARN: missing ${path}"
  fi
done

echo "[4] Suggested manual checks"
echo "- log into niri from SDDM"
echo "- test audio output and microphone"
echo "- test NVIDIA stack on Wayland"
echo "- test docker and libvirt workflows"
