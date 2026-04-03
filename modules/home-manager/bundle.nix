{
  imports = [
    ./ranger/ranger.nix

    # ./gui/vscode.nix

    ./imv/imv.nix
    ./mpv/mpv.nix
    ./obs/obs.nix

    ./terminal/alacritty.nix
    ./terminal/git.nix
    ./terminal/kitty.nix
    ./terminal/lynx.nix
    ./terminal/starship.nix
    ./terminal/zellij.nix
    ./terminal/zsh.nix

    ./mangohud.nix
    # ./symlinks.nix
    ./gui/qt.nix

    ##############
    ## WM (Wayland) ##
    ##############

    # Софт для работы WM на Wayland
    ./wm/rofi/rofi.nix
    ./wm/dunst.nix
    ./wm/niri.nix
  ];
}
