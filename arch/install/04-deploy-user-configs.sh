#!/usr/bin/env bash
set -euo pipefail

ARCH_USER="${ARCH_USER:-${SUDO_USER:-${USER}}}"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
TARGET_HOME="$(getent passwd "${ARCH_USER}" | cut -d: -f6)"

if [[ "${EUID}" -ne 0 ]]; then
  echo "Run as root: sudo bash arch/install/04-deploy-user-configs.sh"
  exit 1
fi

if [[ -z "${TARGET_HOME}" ]]; then
  echo "Could not resolve home for user: ${ARCH_USER}"
  exit 1
fi

mkdir -p "${TARGET_HOME}/.config"

copy_dir() {
  local src="$1"
  local dst="$2"
  mkdir -p "$(dirname "${dst}")"
  rsync -a --delete "${src}/" "${dst}/"
}

copy_file() {
  local src="$1"
  local dst="$2"
  mkdir -p "$(dirname "${dst}")"
  install -m 0644 "${src}" "${dst}"
}

echo "Deploy theme and mime assets"
copy_dir "${ROOT_DIR}/assets/qt5ct" "${TARGET_HOME}/.config/qt5ct"
copy_dir "${ROOT_DIR}/assets/qt6ct" "${TARGET_HOME}/.config/qt6ct"
copy_dir "${ROOT_DIR}/assets/Kvantum" "${TARGET_HOME}/.config/Kvantum"
copy_file "${ROOT_DIR}/assets/mimeapps.list" "${TARGET_HOME}/.config/mimeapps.list"

echo "Deploy app configs from repository"
copy_dir "${ROOT_DIR}/modules/home-manager/mpv" "${TARGET_HOME}/.config/mpv"
copy_dir "${ROOT_DIR}/modules/home-manager/ranger" "${TARGET_HOME}/.config/ranger"
mkdir -p "${TARGET_HOME}/.config/imv"
copy_file "${ROOT_DIR}/modules/home-manager/imv/config" "${TARGET_HOME}/.config/imv/config"
copy_file "${ROOT_DIR}/modules/home-manager/terminal/starship.toml" "${TARGET_HOME}/.config/starship.toml"
copy_dir "${ROOT_DIR}/nvim" "${TARGET_HOME}/.config/nvim"

mkdir -p "${TARGET_HOME}/.config/rofi"
copy_file "${ROOT_DIR}/modules/home-manager/wm/rofi/launcher.rasi" "${TARGET_HOME}/.config/rofi/launcher.rasi"
copy_file "${ROOT_DIR}/modules/home-manager/wm/rofi/power.rasi" "${TARGET_HOME}/.config/rofi/power.rasi"

mkdir -p "${TARGET_HOME}/.config/niri"
copy_file "${ROOT_DIR}/arch/config/niri/config.kdl" "${TARGET_HOME}/.config/niri/config.kdl"

mkdir -p "${TARGET_HOME}/.config/waybar"
copy_file "${ROOT_DIR}/arch/config/waybar/config.jsonc" "${TARGET_HOME}/.config/waybar/config.jsonc"
copy_file "${ROOT_DIR}/arch/config/waybar/style.css" "${TARGET_HOME}/.config/waybar/style.css"

mkdir -p "${TARGET_HOME}/.config/fuzzel"
copy_file "${ROOT_DIR}/arch/config/fuzzel/fuzzel.ini" "${TARGET_HOME}/.config/fuzzel/fuzzel.ini"

mkdir -p "${TARGET_HOME}/.config/dunst"
copy_file "${ROOT_DIR}/arch/config/dunst/dunstrc" "${TARGET_HOME}/.config/dunst/dunstrc"

mkdir -p "${TARGET_HOME}/.config/environment.d"
copy_file "${ROOT_DIR}/arch/config/environment/90-desktop.conf" "${TARGET_HOME}/.config/environment.d/90-desktop.conf"

mkdir -p "${TARGET_HOME}/.config/wallpapers"
if [[ -f "${ROOT_DIR}/modules/nixos/nix-glow-gruvbox.jpg" ]]; then
  copy_file "${ROOT_DIR}/modules/nixos/nix-glow-gruvbox.jpg" "${TARGET_HOME}/.config/wallpapers/nix-glow-gruvbox.jpg"
fi

chown -R "${ARCH_USER}:${ARCH_USER}" "${TARGET_HOME}/.config"

echo "User config deployment complete for ${ARCH_USER}."
