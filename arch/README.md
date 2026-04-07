# Arch Linux Profile (NixOS Parity)

This directory mirrors the active NixOS setup with a practical Arch Linux workflow.
It is split into:

- packages: package manifests for pacman and AUR
- install: step-by-step scripts
- config: desktop and environment configs derived from the current Home Manager setup

## Goals

- Keep the same desktop direction: Wayland + niri + sddm
- Keep the same user workflows: rofi/fuzzel/waybar/dunst/mpv/ranger/nvim
- Keep Qt/Kvantum assets and mime associations from the repository
- Keep virtualization and developer stack close to current Nix setup

## Quick Start

1. Install a minimal Arch base (or run archinstall first).
2. Clone this repository.
3. Run scripts in order from the repository root:

```bash
sudo bash arch/install/01-base-system.sh
bash arch/install/02-packages.sh
sudo bash arch/install/03-services.sh
sudo bash arch/install/04-deploy-user-configs.sh
bash arch/install/05-post-check.sh
```

## Variables

The scripts support environment overrides:

- ARCH_HOSTNAME (default: arch)
- ARCH_TIMEZONE (default: UTC)
- ARCH_LOCALE (default: en_US.UTF-8)
- ARCH_USER (default: current sudo user)

Example:

```bash
ARCH_HOSTNAME=arch ARCH_USER=$USER sudo bash arch/install/01-base-system.sh
```

## Package Roles

The package installer supports role-based installation.

- core: base shell/tools/fonts/pipewire/network
- desktop: UI stack, apps, WM helpers + niri (AUR)
- dev: language toolchains and LSP/CLI dev stack
- gaming: Steam/Wine/Vulkan
- vm: Docker/Libvirt/VirtualBox/Waydroid
- gpu-nvidia-open: Modern NVIDIA drivers (Linux 6.6+, experimental)
- gpu-nvidia-proprietary: Classic NVIDIA drivers (recommended)
- gpu-amd: AMD GPU stack
- gpu-intel: Intel GPU stack

Examples:

```bash
# Full profile (default)
bash arch/install/02-packages.sh

# Minimal desktop first (no GPU drivers yet)
bash arch/install/02-packages.sh --roles core,desktop --no-aur

# With NVIDIA (choose one driver variant)
bash arch/install/02-packages.sh --roles gpu-nvidia-proprietary
bash arch/install/02-packages.sh --roles gpu-nvidia-open

# Add development stack later
bash arch/install/02-packages.sh --roles dev

# Legacy monolithic mode
bash arch/install/02-packages.sh --legacy
```

## NVIDIA + Wayland + Niri

If you have NVIDIA hardware:

1. **Install GPU drivers early** (before first graphical login):

   ```bash
   # Recommended: proprietary drivers (most compatible)
   bash arch/install/02-packages.sh --roles gpu-nvidia-proprietary --no-aur
   
   # OR experimental: open-source kernel drivers
   bash arch/install/02-packages.sh --roles gpu-nvidia-open --no-aur
   ```

2. **Then install desktop** (niri will compile against drivers):

   ```bash
   bash arch/install/02-packages.sh --roles desktop,dev,vm,gaming
   ```

3. **Black screen troubleshooting**:

   - Exit to console: Ctrl+Alt+F2
   - Verify driver loaded:
     ```bash
     lsmod | grep nvidia
     ```
   - Check logs:
     ```bash
     journalctl -b -u sddm
     journalctl -b | grep -i nvidia
     ```
   - Restart display manager:
     ```bash
     systemctl restart display-manager
     ```

## Notes

- Some packages are in AUR. Install yay (or paru) before running package script.
- GPU drivers should be installed **before** first graphical session.
- The scripts are idempotent where possible and safe to re-run.
