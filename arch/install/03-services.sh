#!/usr/bin/env bash
set -euo pipefail

ARCH_USER="${ARCH_USER:-${SUDO_USER:-${USER}}}"

if [[ "${EUID}" -ne 0 ]]; then
  echo "Run as root: sudo bash arch/install/03-services.sh"
  exit 1
fi

enable_if_exists() {
  local unit="$1"
  if systemctl list-unit-files --type=service --type=socket | grep -q "^${unit}"; then
    systemctl enable "${unit}"
  else
    echo "Skip: ${unit} is not installed"
  fi
}

echo "Enable core services"
enable_if_exists sddm.service
enable_if_exists bluetooth.service
enable_if_exists docker.service

# Newer libvirt setups may use virtqemud instead of libvirtd.
if systemctl list-unit-files --type=service --type=socket | grep -q '^libvirtd.service'; then
  systemctl enable libvirtd.service
elif systemctl list-unit-files --type=service --type=socket | grep -q '^virtqemud.service'; then
  systemctl enable virtqemud.service
elif systemctl list-unit-files --type=service --type=socket | grep -q '^virtqemud.socket'; then
  systemctl enable virtqemud.socket
else
  echo "Skip: libvirt daemon is not installed"
fi

if systemctl list-unit-files | grep -q '^waydroid-container.service'; then
  systemctl enable waydroid-container.service
fi

echo "User group setup for ${ARCH_USER}"
groups_to_add=(wheel input storage video)

for g in docker libvirtd vboxusers; do
  if getent group "${g}" >/dev/null 2>&1; then
    groups_to_add+=("${g}")
  fi
done

usermod -aG "$(IFS=,; echo "${groups_to_add[*]}")" "${ARCH_USER}"

echo "Shell and virtualization extras"
chsh -s /bin/zsh "${ARCH_USER}" || true
if command -v virsh >/dev/null 2>&1; then
  if [[ -S /run/libvirt/libvirt-sock ]] || [[ -S /run/libvirt/virtqemud-sock ]]; then
    virsh -c qemu:///system net-autostart default || true
  else
    echo "Skip: libvirt socket is not available yet"
  fi
fi

echo "Configure SDDM theme"
if [[ -d /usr/share/sddm/themes/chili ]]; then
  install -d /etc/sddm.conf.d
  cat > /etc/sddm.conf.d/10-theme.conf <<'EOF'
[Theme]
Current=chili
EOF
  echo "SDDM theme set to chili"
else
  echo "Skip: chili theme is not installed (install chili-sddm-theme from AUR)"
fi

echo "Service setup complete. Reboot is recommended."
