# NixOS Private Dots

NixOS + Home Manager конфиг с Wayland (niri), декларативным desktop-окружением, темами Stylix и пользовательскими модулями.

## Структура

- `assets` - статические ассеты (qt5ct/qt6ct/Kvantum)
- `modules/nixos` - системные модули NixOS
- `modules/home-manager` - пользовательские модули Home Manager
- `nixos` - точка входа системы
- `nvim` - конфиг Neovim

## Быстрый старт

1. Заполни пользователя в `flake.nix`:
- `username`
- `user.git.name`
- `user.git.email`

2. Проверь опциональные модули перед первым применением:
- `modules/nixos/filesystems.nix`
- `modules/nixos/hibernate.nix`
- `modules/home-manager/symlinks.nix`

3. Применение:

```sh
sudo nixos-rebuild switch --flake .#nixos
```

## Безопасный цикл обновления

```sh
sudo nixos-rebuild build --flake .#nixos
sudo nixos-rebuild test --flake .#nixos
sudo nixos-rebuild switch --flake .#nixos
```

Если `test` нестабилен:

```sh
sudo nixos-rebuild boot --flake .#nixos
```

Откат:

```sh
sudo nixos-rebuild switch --rollback
```

## Установка с live ISO

1. Смонтируй root в `/mnt`, EFI в `/mnt/boot`.
2. Сгенерируй hardware-конфиг:

```sh
nixos-generate-config --root /mnt
```

3. Установи систему из flake:

```sh
nixos-install --flake /mnt/nixos-private-dots#nixos
```

## Известные проблемы

1. После крупных изменений возможны конфликтующие сервисы.
2. Часть GUI-приложений может переписывать `~/.config`.
3. TUN/прокси-клиенты могут требовать доп. настройки прав/ядра.

Рекомендация: сначала `build/test`, потом `switch`.

## Niri: актуальные бинды

Источник правды: `modules/home-manager/wm/niri.nix`.

### Основные

- `Super+Shift+/` - показать overlay хоткеев
- `Super+Shift+Return` - Alacritty
- `Super+Return` - floating Alacritty
- `Super+T` - Alacritty
- `Super+Shift+T` - floating Alacritty
- `Super+Ctrl+T` - Kitty
- `Super+Ctrl+Shift+T` - floating Kitty
- `Super+Q` - закрыть окно
- `Super+Shift+C` - закрыть окно
- `Super+F` - toggle floating
- `Super+Shift+F` - fullscreen
- `Super+R` - смена preset-ширины колонки
- `Super+Alt+L` - lockscreen
- `Super+Shift+E` - quit
- `Ctrl+Alt+Delete` - quit

### Навигация

- `Super+Arrows` / `Super+HJKL` - фокус
- `Super+Shift+Arrows` - move window/column
- `Super+Ctrl+Arrows` - move window/column
- `Super+PageUp/PageDown` - workspace up/down
- `Super+Escape` - focus workspace down
- `Super+Ctrl+PageUp/PageDown` - отправить колонку в workspace up/down
- `Super+1..9` - focus workspace
- `Super+Shift+1..9` - move column to workspace
- `Super+Ctrl+1..9` - move column to workspace

### Launcher и утилиты

- `Super+A` - fuzzel
- `Super+D` - fuzzel
- `Super+Tab` - rofi window switcher
- `Super+C` - rofi calc
- `Super+P` - rofi-pass
- `Super+V` - clipmenu
- `Super+Backspace` - rofi power-menu

### Приложения

- `Super+B` - Firefox
- `Super+Shift+B` - Vivaldi
- `Super+Ctrl+N` - Obsidian
- `Super+E` - Thunar
- `Super+I` - VS Code (`--ozone-platform=wayland`)
- `Super+M` - btop в терминале
- `Super+G` - Planify

### Уведомления и мультимедиа

- `Super+N` - dunst history-pop
- `Super+Shift+N` - dunst close-all
- `XF86Audio*` - mute/volume/playerctl
- `XF86MonBrightnessUp/Down` - brightnessctl

### Скриншоты

- `Print` - область
- `Alt+Print` - экран
- `Ctrl+Print` - окно

## Waybar

Текущая панель:

- pinned launchers: Firefox, Alacritty, Thunar, VS Code
- workspaces: `niri/workspaces`
- статус: язык, яркость, звук, CPU, сеть, батарея, часы, трей

Источник: `modules/home-manager/wm/waybar/waybar.nix`.

## Fuzzel

- `Super+A` / `Super+D`
- тёмная тема настроена в `modules/home-manager/wm/fuzzel.nix`
- добавлен desktop-entry для VS Code с Wayland-флагами

## Обои

Текущий путь:

- `modules/nixos/nix-glow-gruvbox.jpg`

Чтобы сменить фон, достаточно заменить этот файл (с тем же именем) и сделать rebuild.

## Neovim

Конфиг управляется через Home Manager модуль:

- `modules/home-manager/terminal/neovim.nix`
- исходники конфига: `nvim/`

Что включено:

- `programs.neovim.enable = true`
- alias: `vi`, `vim`
- LSP/tools: `lua-language-server`, `nil`, `typescript-language-server`, `pyright`, `gopls`, `clang-tools`
- форматтеры: `stylua`, `black`, `eslint`, `nodePackages.prettier`, `nixpkgs-fmt`
- поиск: `ripgrep`, `fd`, `fzf`

Базовые бинды/подсказки:

- `Space` - leader
- `Space sk` - поиск биндов
- `Space sf` - поиск файлов
- `Space sg` - grep по проекту
- `Space Sc` - создать сессию
- `Space Sd` - удалить сессию
- `\\` - file tree

## MPV (кратко)

В проекте есть конфиг mpv с uosc/скриптами:

- local clip: `g/h`, `G/H`, `Ctrl+r`, `Alt+r`
- streamsave: `Ctrl+z`, `Ctrl+x`, `Alt+z`, `l`
- copy info: `Ctrl+f/p/t/s/d/m`

Основные стандартные бинды mpv:

- `[` `]` - скорость
- `Backspace` - сброс скорости
- `Arrows` - перемотка
- `f` - fullscreen
- `s` - screenshot

## Темы

Используется Stylix + Base16 с акцентом на Gruvbox dark medium (`base00 = #282828`).

Полезно помнить:

- `base00..base07` - фон/текст
- `base08..base0F` - акценты (ошибки, warning, strings, keywords и т.д.)

Иконки Nerd Fonts: https://www.nerdfonts.com/cheat-sheet
