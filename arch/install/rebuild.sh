#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
ARCH_USER="${ARCH_USER:-${USER}}"
ROLES="core,desktop"
WITH_AUR=1
SKIP_PACKAGES=0
SKIP_SERVICES=0
SKIP_CONFIGS=0
DO_REBOOT=0

usage() {
  cat <<'EOF'
Usage: bash arch/install/rebuild.sh [options]

Options:
  --roles <csv>       Roles for 02-packages.sh (default: core,desktop)
  --no-aur            Skip AUR installs
  --skip-packages     Do not run package installation step
  --skip-services     Do not run system services step
  --skip-configs      Do not run user config deploy step
  --reboot            Reboot at the end
  -h, --help          Show help

Examples:
  bash arch/install/rebuild.sh
  bash arch/install/rebuild.sh --roles core,desktop,dev --no-aur
  ARCH_USER=sixxxsta bash arch/install/rebuild.sh --roles core,desktop --reboot
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --roles)
      [[ $# -ge 2 ]] || { echo "--roles requires a value"; exit 1; }
      ROLES="$2"
      shift 2
      ;;
    --no-aur)
      WITH_AUR=0
      shift
      ;;
    --skip-packages)
      SKIP_PACKAGES=1
      shift
      ;;
    --skip-services)
      SKIP_SERVICES=1
      shift
      ;;
    --skip-configs)
      SKIP_CONFIGS=1
      shift
      ;;
    --reboot)
      DO_REBOOT=1
      shift
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

if [[ ! -f "${ROOT_DIR}/arch/install/02-packages.sh" ]]; then
  echo "Repository layout not found. Run from inside nixos-private-dots."
  exit 1
fi

echo "== Arch rebuild =="
echo "User: ${ARCH_USER}"
echo "Roles: ${ROLES}"

if [[ "${SKIP_PACKAGES}" -eq 0 ]]; then
  echo "[1/3] Packages"
  if [[ "${WITH_AUR}" -eq 1 ]]; then
    bash "${ROOT_DIR}/arch/install/02-packages.sh" --roles "${ROLES}"
  else
    bash "${ROOT_DIR}/arch/install/02-packages.sh" --roles "${ROLES}" --no-aur
  fi
else
  echo "[1/3] Packages: skipped"
fi

if [[ "${SKIP_SERVICES}" -eq 0 ]]; then
  echo "[2/3] Services"
  ARCH_USER="${ARCH_USER}" sudo bash "${ROOT_DIR}/arch/install/03-services.sh"
else
  echo "[2/3] Services: skipped"
fi

if [[ "${SKIP_CONFIGS}" -eq 0 ]]; then
  echo "[3/3] User configs"
  ARCH_USER="${ARCH_USER}" sudo bash "${ROOT_DIR}/arch/install/04-deploy-user-configs.sh"
else
  echo "[3/3] User configs: skipped"
fi

echo "Rebuild complete."

if [[ "${DO_REBOOT}" -eq 1 ]]; then
  echo "Rebooting..."
  sudo reboot
fi
