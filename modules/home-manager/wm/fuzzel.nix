{ lib, config, pkgs, ... }:
{
  home.packages = with pkgs; [ vscode ];

  # Override desktop launcher so app menus (fuzzel) run VS Code with Wayland flags.
  xdg.desktopEntries.code = {
    name = "Visual Studio Code";
    genericName = "Text Editor";
    comment = "Code Editing. Redefined.";
    exec = "${pkgs.vscode}/bin/code --ozone-platform=wayland --enable-features=UseOzonePlatform %F";
    icon = "vscode";
    terminal = false;
    categories = [
      "Utility"
      "TextEditor"
      "Development"
      "IDE"
    ];
    mimeType = [
      "text/plain"
      "inode/directory"
    ];
    startupNotify = true;
  };

  programs.fuzzel = {
    enable = true;
    settings = lib.mkForce {
      main = {
        terminal = "alacritty";
        font = "JetBrains Mono:size=14";
        width = 52;
        lines = 12;
        horizontal-pad = 18;
        vertical-pad = 14;
        inner-pad = 8;
        layer = "overlay";
        icon-theme = "Papirus-Dark";
      };

      border = {
        width = 2;
        radius = 10;
      };

      colors = {
        background = "1d2021ff";
        text = "ebdbb2ff";
        prompt = "fe8019ff";
        placeholder = "a89984ff";
        input = "ebdbb2ff";
        match = "fabd2fff";
        selection = "3c3836ff";
        selection-text = "fbf1c7ff";
        selection-match = "fe8019ff";
        counter = "a89984ff";
        border = "d65d0eff";
      };
    };
  };
}
