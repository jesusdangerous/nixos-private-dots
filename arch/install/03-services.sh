#!/usr/bin/env bash
set -euo pipefail

ARCH_USER="${ARCH_USER:-${SUDO_USER:-${USER}}}"

if [[ "${EUID}" -ne 0 ]]; then
  echo "Run as root: sudo bash arch/install/03-services.sh"
  exit 1
fi

echo "Enable core services"
systemctl enable sddm
systemctl enable bluetooth
systemctl enable docker
systemctl enable libvirtd

if systemctl list-unit-files | grep -q '^waydroid-container.service'; then
  systemctl enable waydroid-container
fi

echo "User group setup for ${ARCH_USER}"
usermod -aG wheel,input,libvirtd,storage,docker,video,vboxusers "${ARCH_USER}"

echo "Shell and virtualization extras"
chsh -s /bin/zsh "${ARCH_USER}" || true
virsh net-autostart default || true

echo "Service setup complete. Reboot is recommended."
