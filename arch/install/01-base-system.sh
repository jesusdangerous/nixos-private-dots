#!/usr/bin/env bash
set -euo pipefail

ARCH_HOSTNAME="${ARCH_HOSTNAME:-arch}"
ARCH_TIMEZONE="${ARCH_TIMEZONE:-UTC}"
ARCH_LOCALE="${ARCH_LOCALE:-en_US.UTF-8}"

if [[ "${EUID}" -ne 0 ]]; then
  echo "Run as root: sudo bash arch/install/01-base-system.sh"
  exit 1
fi

echo "[1/7] Timezone"
ln -sf "/usr/share/zoneinfo/${ARCH_TIMEZONE}" /etc/localtime
hwclock --systohc

echo "[2/7] Locale"
grep -q "^${ARCH_LOCALE}" /etc/locale.gen || echo "${ARCH_LOCALE} UTF-8" >> /etc/locale.gen
grep -q "^ru_RU.UTF-8" /etc/locale.gen || echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
printf "LANG=%s\n" "${ARCH_LOCALE}" > /etc/locale.conf

echo "[3/7] Hostname"
printf "%s\n" "${ARCH_HOSTNAME}" > /etc/hostname
cat > /etc/hosts <<EOF
127.0.0.1 localhost
::1 localhost
127.0.1.1 ${ARCH_HOSTNAME}.localdomain ${ARCH_HOSTNAME}
EOF

echo "[4/7] Keyboard"
printf "KEYMAP=us\n" > /etc/vconsole.conf

echo "[5/7] Pacman keyring"
pacman -Sy --noconfirm archlinux-keyring

echo "[6/7] Core packages"
pacman -S --needed --noconfirm base-devel grub efibootmgr networkmanager

echo "[7/7] Enable NetworkManager"
systemctl enable NetworkManager

echo "Base system bootstrap complete."
