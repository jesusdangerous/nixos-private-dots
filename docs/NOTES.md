## Notes

Короткие заметки по актуальной конфигурации проекта.

## Основное

- Активный WM: niri (Wayland).
- Тема и цвета: Stylix + ассеты из каталога assets.
- Пользователь задается в одном месте: flake.nix -> user.
- Установка и обновление: через flake профиль nixos.

## Опциональные модули

По умолчанию можно держать выключенными и включать под свою машину:

- modules/nixos/filesystems.nix
- modules/nixos/hibernate.nix
- modules/home-manager/symlinks.nix
- modules/home-manager/gui/vscode.nix

## Полезные команды

```sh
sudo nixos-rebuild build --flake .#nixos
sudo nixos-rebuild test --flake .#nixos
sudo nixos-rebuild switch --flake .#nixos
sudo nixos-rebuild switch --rollback
```

## Обновление входов flake

```sh
nix flake update
```

## Где менять пользователя

- flake.nix:
- username
- user.git.name
- user.git.email
