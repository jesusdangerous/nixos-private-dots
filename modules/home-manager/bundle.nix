let
  importNixFiles = dir:
    let
      entries = builtins.readDir dir;
      nixFiles = builtins.filter
        (name: entries.${name} == "regular" && builtins.match ".*\\.nix" name != null)
        (builtins.attrNames entries);
    in
      builtins.map (name: dir + "/${name}") nixFiles;
in {
  imports = [
    ./ranger/ranger.nix

    # ./gui/vscode.nix

    ./imv/imv.nix
    ./mpv/mpv.nix
    ./obs/obs.nix

  ] ++ importNixFiles ./terminal ++ [

    ./mangohud.nix
    # ./symlinks.nix
    ./gui/qt.nix

    ##############
    ## WM (Wayland) ##
    ##############

    # Софт для работы WM на Wayland
    ./wm/rofi/rofi.nix
    ./wm/fuzzel.nix
    ./wm/dunst.nix
    ./wm/niri.nix
    ./wm/waybar/waybar.nix
    ./wm/wallpaper.nix
  ];
}
