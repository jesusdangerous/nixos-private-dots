## NixOS Private Dots

NixOS + Home Manager конфиг с Wayland/niri, NVIDIA и декларативной пользовательской средой.

## Структура

- docs: документация и заметки
- assets: статические UI ассеты (qt5ct/qt6ct/Kvantum)
- modules/nixos: системные модули NixOS
- modules/home-manager: пользовательские модули Home Manager
- nixos: точка входа системы

## Быстрый старт

1. Измени пользователя в flake:
- username
- git.name
- git.email

2. Проверь опциональные модули в imports:
- modules/nixos/filesystems.nix
- modules/nixos/hibernate.nix
- modules/home-manager/symlinks.nix

3. Применение:
```sh
sudo nixos-rebuild switch --flake .#nixos
```

## Установка с live ISO

1. Смонтируй root в /mnt и EFI в /mnt/boot.
2. Сгенерируй hardware конфиг:
```sh
nixos-generate-config --root /mnt
```
3. Поставь систему из flake:
```sh
nixos-install --flake /mnt/nixos-private-dots#nixos
```

## Документация

- docs/SETUP_SAFE.md: безопасный цикл build/test/switch и rollback
- docs/BINDINGS.md: актуальные хоткеи niri
- docs/NOTES.md: полезные заметки по проекту
- docs/PROBLEMS.md: известные проблемы и обходы
- docs/THEMES.md: таблицы цветов и иконок
