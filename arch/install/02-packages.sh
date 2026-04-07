#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
PACMAN_LIST="${ROOT_DIR}/arch/packages/pacman.txt"
AUR_LIST="${ROOT_DIR}/arch/packages/aur.txt"
ROLE_DIR="${ROOT_DIR}/arch/packages/roles"

DEFAULT_ROLES=(core desktop dev gaming vm)
ROLES=("${DEFAULT_ROLES[@]}")
WITH_AUR=1
LEGACY_MODE=0

usage() {
  cat <<'EOF'
Usage: bash arch/install/02-packages.sh [options]

Options:
  --roles core,desktop,dev,gaming,vm   Install only selected roles
  --no-aur                             Skip AUR installation
  --legacy                             Use monolithic lists (pacman.txt + aur.txt)
  --list-roles                         Show available roles and exit
  -h, --help                           Show this help
EOF
}

list_roles() {
  echo "Available roles: core, desktop, dev, gaming, vm"
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --roles)
      [[ $# -ge 2 ]] || { echo "--roles requires a value"; exit 1; }
      IFS=',' read -r -a ROLES <<< "$2"
      shift 2
      ;;
    --no-aur)
      WITH_AUR=0
      shift
      ;;
    --legacy)
      LEGACY_MODE=1
      shift
      ;;
    --list-roles)
      list_roles
      exit 0
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      usage
      exit 1
      ;;
  esac
done

if [[ "${EUID}" -eq 0 ]]; then
  echo "Run as user with sudo rights, not as root."
  exit 1
fi

if ! command -v pacman >/dev/null 2>&1; then
  echo "pacman is required."
  exit 1
fi

declare -A seen_pacman
declare -a pacman_pkgs

declare -A seen_aur
declare -a aur_pkgs

append_unique_from_file() {
  local file="$1"
  local kind="$2"
  [[ -f "${file}" ]] || return 0

  while IFS= read -r line; do
    [[ -z "${line}" || "${line}" =~ ^[[:space:]]*# ]] && continue
    if [[ "${kind}" == "pacman" ]]; then
      if [[ -z "${seen_pacman[${line}]+x}" ]]; then
        seen_pacman["${line}"]=1
        pacman_pkgs+=("${line}")
      fi
    else
      if [[ -z "${seen_aur[${line}]+x}" ]]; then
        seen_aur["${line}"]=1
        aur_pkgs+=("${line}")
      fi
    fi
  done < "${file}"
}

if [[ "${LEGACY_MODE}" -eq 1 ]]; then
  echo "Legacy mode: using ${PACMAN_LIST} and ${AUR_LIST}"
  append_unique_from_file "${PACMAN_LIST}" "pacman"
  append_unique_from_file "${AUR_LIST}" "aur"
else
  echo "Role mode: ${ROLES[*]}"
  for role in "${ROLES[@]}"; do
    case "${role}" in
      core|desktop|dev|gaming|vm) ;;
      *)
        echo "Unknown role: ${role}"
        list_roles
        exit 1
        ;;
    esac

    append_unique_from_file "${ROLE_DIR}/${role}.pacman.txt" "pacman"
    append_unique_from_file "${ROLE_DIR}/${role}.aur.txt" "aur"
  done
fi

if [[ "${#pacman_pkgs[@]}" -gt 0 ]]; then
  echo "Installing ${#pacman_pkgs[@]} official packages"
  sudo pacman -Syu --needed --noconfirm "${pacman_pkgs[@]}"
else
  echo "No official packages selected."
fi

if [[ "${WITH_AUR}" -eq 0 ]]; then
  echo "AUR disabled by --no-aur"
elif command -v yay >/dev/null 2>&1; then
  if [[ "${#aur_pkgs[@]}" -gt 0 ]]; then
    echo "Installing ${#aur_pkgs[@]} AUR packages"
    yay -S --needed --noconfirm "${aur_pkgs[@]}"
  else
    echo "No AUR packages selected."
  fi
else
  echo "yay was not found. Skipping AUR packages."
  echo "Install yay, then rerun this script."
fi

echo "Package installation step complete."
