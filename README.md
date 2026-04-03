## Навигация

- [Другие README файлы в этих дотсах](#другие-readme-файлы-в-этих-дотсах)
- [TODO](#todo)
- [Мини гайд по NixOS](#мини-гайд-по-nixos)
- [Процесс установки](#процесс-установки)
  - [Первый способ](#первый-способ)
  - [Второй способ](#второй-способ)
- [После установки надо](#после-установки-надо)
- [Изменения для виртуалок](#изменения-для-виртуалок)

## Другие README файлы в этих дотсах

- [Бинды системы](./docs/BINDINGS.md)
- [Список базового софта в системе и доп информация](./docs/NOTES.md)
- [Цвета и иконки тем, храню для себя](./docs/THEMES.md)
- [Список известных проблем при настройке системы](./docs/PROBLEMS.md)
- [Безопасная настройка и обновление](./docs/SETUP_SAFE.md)
- [Wayland/niri конфиг](./modules/home-manager/wm/niri.nix)
- [Описание плагинов для mpv](./modules/home-manager/mpv/README.md)
- [NeoVim config](./nvim/README.md)

## Мини гайд по NixOS

- Одинаковые вещи могут делаться разными способами. Это норма, ведь nix считается языком програмимрования. По началу меня это бесило, когда читал чужие дотсы
- Нюансы работы NixOS в [этом](https://www.youtube.com/watch?v=7f19R8BWUnU&t=960s) видео. Мне понравилось
- [Плейлист](https://www.youtube.com/playlist?list=PLko9chwSoP-15ZtZxu64k_CuTzXrFpxPE) с английскими видео. Мне больше всего понравились видео под номерами [16](https://youtu.be/a67Sv4Mbxmc), [18](https://youtu.be/b641h63lqy0), [21](https://youtu.be/rEovNpg7J0M), [27](https://youtu.be/ljHkWgBaQWU) и [28](https://youtu.be/JCeYq72Sko0).
- Пакеты искать [тут](https://search.nixos.org/packages). Параметры для сток NixOS [тут](https://search.nixos.org/options). Параметры для home-manager [тут](https://home-manager-options.extranix.com/?query=&release=master). Для моих конфигов надо обязательно искать в unstable ветке, ибо параметры могут отличаться.
- Для системной темы тут используется stylix. Все его параметры можно найти [тут](https://stylix.danth.me/options/nixos.html).

## Процесс установки

Сначала ставим минимальный NixOS без DE. Дальше один раз включаем flakes и git в базовой системе, чтобы можно было забилдить этот конфиг без лишней возни.

Для этого пишем следующее:

```sh
sudo nano /etc/nixos/configuration.nix
```

Я добавил туда `nix.settings.experimental-features = [ "nix-command" "flakes" ];` сразу после настроек `boot`. Ниже, почти в самом конце, в `environment.systemPackages = with pkgs;` я добавил пакеты `wget, git, curl`. В итоге получился такой конфиг (написал лишь его часть):

```nix
{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    curl
    fastfetch
  ];
}
```

После этого сохраняем и пишем в терминале это:

```sh
sudo nixos-rebuild switch
```

Дальше есть два способа. Перед использованием любого из них я рекомендую сделать форк и внести только эти изменения в конфиг перед установкой:

- Переменную `username` в `nixos/configuration.nix`.
- `username` и `homeDirectory` в `nixos/home.nix`.
- `userName` и `userEmail` в `modules/home-manager/terminal/git.nix`.

Этот конфиг уже собран без AMD-специфики, поэтому руками вычищать `rocmSupport`, `amdgpu` или `videoDrivers` больше не нужно.

А это можно донастроить уже в готовой системе
- Путь до `home` в `assets/qt5ct/qt5ct.conf` и `assets/qt6ct/qt6ct.conf`.
- Параметры мониторов можно добавить прямо в `modules/home-manager/wm/niri.nix`, если нужна фиксированная раскладка экранов.
- Если надо задать симлинки, то для этого есть файл `modules/home-manager/symlinks.nix`. Там сейчас мои симлинки, их лучше удалить. Чтоб файл заработал, надо раскомментировать `./symlinks.nix` в файле `modules/home-manager/bundle.nix`.
- Если надо монтировать другие диски, то для этого есть файл `modules/nixos/filesystems.nix`. Там сейчас мой второй ссд. Чтоб файл заработал, надо раскомментировать `./filesystems.nix` в файле `modules/nixos/bundle.nix`.
- Если нужна гибернация, то её можно настроить в `modules/nixos/hibernate.nix`. Там надо указать uuid и офсет для swap файла. Чтоб файл заработал, надо раскомментировать `./hibernate.nix` в файле `modules/nixos/bundle.nix`.

С гитом есть нюанс. Если захочешь потом создать свои конфиги или добавить новые файлы, на которые надо ссылаться из nix, то надо указывать либо полный путь до файла, либо добавлять файл в гит. Если указывать относительный путь, как сделано в моих `bundle.nix`, то все эти файлы должны находиться в гите, либо каталог дотсов должен быть без гита вовсе. Если в каталоге дотсов инициализирован репозиторий гита, то в относительных путях он не видит файлы из `gitignore` или просто не отслеживаемые гитом файлы.

### Первый способ

Установить систему одной командой (я написал пример для github, но сейчас мои дотсы есть лишь на forgejo, не знаю как с него использовать такой синтаксис):
```sh
sudo nixos-rebuild boot --flake github:Buliway/nixos-private-dots --impure
```

Чтоб использовать с репой forgejo, можно попробовать такой синтаксис `git@git.buliway.ru:Buliway/nixos-private-dots`.

Параметр `boot` делает так, что настройки не применяются сразу. После установки надо будет перезапустить пк. Если хочешь проверить как оно заработает без ребута пк, то используй `switch` вместо `boot`.

### Второй способ

Клонировать репозиторий и ребилдить систему с указанием пути:
```sh
git clone https://git.buliway.ru/buliway/nixos-private-dots
sudo nixos-rebuild boot --impure --flake ~/nixos-private-dots
```
Параметр `boot` делает так, что настройки не применяются сразу. После установки надо будет перезапустить пк. Если хочешь проверить как оно заработает без ребута пк, то используй `switch` вместо `boot`.

## После установки надо

Эта заметка частично для меня. Каждый ставит то, что ему надо

- Включить подкачку на 64 гига в `/etc/nixos/hardware-configuration.nix` через такой синтаксис:
```nix
  swapDevices = [ {
    device = "/swapfile";
    size = 64*1024; # В мегабайтах
  } ];
```
- Настроить гибренацию в `modules/nixos/hibernate.nix`
- Проверить, что ассоциации файлов и тема Qt устраивают тебя: они теперь задаются декларативно через `modules/home-manager/gui/qt.nix`.
- Настроить приложения `Qt5 Settings`, `Qt6 Settings` и `Kvantum`. Там надо выбрать свою системную тему. Вроде всё интуитивно понятно будет. Можно попробовать обновить систему, в надежде, что системная тема `stylix` начнёт работать с приложениями `qt`. Для этого надо будет закомментить настройки `qt` в конфиге `stylix`.
- Руками настроить `thunar`, `discord`, `telegram`, `steam`, `strawberry` и бинды для `ksnip`
- Добавить gpg ключи
```sh
gpg --import /path/to/your-key.gpg
```
Если не работает, то смотришь список ключей. Копируешь ID нужного и используешь во второй команде.
```sh
gpg --list-keys
gpg --edit-key ID-ключа
```
В этом режиме надо написать trust и выбрать степень доверия. Например 5 для своих ключей можно задать, это прям самое максимально доверие. Потом Ctrl + D чтоб выйти.

## Изменения для виртуалок

Виртуалка требует минимум 100гб памяти. Если хочешь меньше, то удали огромную кучу софта из конфигов, который тебе не нужен на виртуалке.

Это надо, чтоб включить коннект по ssh к виртуалке и сделать с ней общий буфер обмена. Ну и ещё параметры экрана меняю на один 1080p монитор на 60 герц.

В файле `modules/nixos/virtualisation.nix` раскомментировать эти строки:
```diff
+  services = {
+    openssh.enable = true; # Это ставится на виртуалку, чтоб к ней конект по ssh работал.
+    spice-vdagentd.enable = true; # Clipboard sharing
+    qemuGuest = {
+      enable = true; # Fix resolution
+      package = pkgs.qemu_full;
+    };
+  };
```
В файле `modules/home-manager/wm/niri.nix` можно добавить свои output-блоки, если виртуалка или основной компьютер всегда работают с одной и той же раскладкой мониторов.
