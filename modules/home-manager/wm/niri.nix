{ pkgs, config, ... }:
let
  rofiLauncher = "${config.home.homeDirectory}/.config/rofi/launcher.rasi";
  rofiPower = "${config.home.homeDirectory}/.config/rofi/power.rasi";
in {
  home.packages = with pkgs; [
    swaylock
  ];

  xdg.configFile."niri/config.kdl".text = ''
    input {
      keyboard {
        xkb {
          layout "us,ru"
          options "grp:caps_toggle"
        }
      }

      mouse {
        accel-profile "flat"
      }

      touchpad {
        tap
        natural-scroll
        accel-profile "flat"
      }
    }

    layout {
      gaps 10
      center-focused-column "never"

      default-column-width {
        proportion 0.5
      }

      focus-ring {
        width 3
        active-color "#${config.lib.stylix.colors.base09}"
        inactive-color "#${config.lib.stylix.colors.base0B}"
      }

      border {
        width 1
        active-color "#${config.lib.stylix.colors.base08}"
        inactive-color "#${config.lib.stylix.colors.base01}"
      }
    }

    spawn-at-startup "nm-applet"

    binds {
      Mod+Shift+Slash { show-hotkey-overlay; }

      Mod+Shift+Return { spawn "alacritty"; }
      Mod+Return { spawn "alacritty" "--class" "floating-terminal"; }
      Mod+T { spawn "alacritty"; }
      Mod+Shift+T { spawn "alacritty" "--class" "floating-terminal"; }
      Mod+Ctrl+T { spawn "kitty"; }
      Mod+Ctrl+Shift+T { spawn "kitty" "--class" "floating-terminal"; }
      Mod+Tab { spawn "${pkgs.rofi}/bin/rofi" "-show" "window" "-theme" "${rofiLauncher}"; }

      Mod+Shift+C { close-window; }
      Mod+F { toggle-window-floating; }
      Mod+Shift+F { fullscreen-window; }
      Mod+Alt+L { spawn "swaylock"; }
      Mod+Shift+E { quit; }
      Ctrl+Alt+Delete { quit; }

      Mod+Left { focus-column-left; }
      Mod+Down { focus-window-down; }
      Mod+Up { focus-window-up; }
      Mod+Right { focus-column-right; }
      Mod+H { focus-column-left; }
      Mod+J { focus-window-down; }
      Mod+K { focus-window-up; }
      Mod+L { focus-column-right; }

      Mod+Shift+Left { move-column-left; }
      Mod+Shift+Down { move-window-down; }
      Mod+Shift+Up { move-window-up; }
      Mod+Shift+Right { move-column-right; }
      Mod+Ctrl+Left { move-column-left; }
      Mod+Ctrl+Down { move-window-down; }
      Mod+Ctrl+Up { move-window-up; }
      Mod+Ctrl+Right { move-column-right; }

      Mod+Page_Down { focus-workspace-down; }
      Mod+Page_Up { focus-workspace-up; }
      Mod+Escape { focus-workspace-down; }
      Mod+Ctrl+Page_Down { move-column-to-workspace-down; }
      Mod+Ctrl+Page_Up { move-column-to-workspace-up; }

      Mod+1 { focus-workspace 1; }
      Mod+2 { focus-workspace 2; }
      Mod+3 { focus-workspace 3; }
      Mod+4 { focus-workspace 4; }
      Mod+5 { focus-workspace 5; }
      Mod+6 { focus-workspace 6; }
      Mod+7 { focus-workspace 7; }
      Mod+8 { focus-workspace 8; }
      Mod+9 { focus-workspace 9; }

      Mod+Shift+1 { move-column-to-workspace 1; }
      Mod+Shift+2 { move-column-to-workspace 2; }
      Mod+Shift+3 { move-column-to-workspace 3; }
      Mod+Shift+4 { move-column-to-workspace 4; }
      Mod+Shift+5 { move-column-to-workspace 5; }
      Mod+Shift+6 { move-column-to-workspace 6; }
      Mod+Shift+7 { move-column-to-workspace 7; }
      Mod+Shift+8 { move-column-to-workspace 8; }
      Mod+Shift+9 { move-column-to-workspace 9; }
      Mod+Ctrl+1 { move-column-to-workspace 1; }
      Mod+Ctrl+2 { move-column-to-workspace 2; }
      Mod+Ctrl+3 { move-column-to-workspace 3; }
      Mod+Ctrl+4 { move-column-to-workspace 4; }
      Mod+Ctrl+5 { move-column-to-workspace 5; }
      Mod+Ctrl+6 { move-column-to-workspace 6; }
      Mod+Ctrl+7 { move-column-to-workspace 7; }
      Mod+Ctrl+8 { move-column-to-workspace 8; }
      Mod+Ctrl+9 { move-column-to-workspace 9; }

      Mod+D { spawn "${pkgs.rofi}/bin/rofi" "-show" "drun" "-show-icons" "-theme" "${rofiLauncher}"; }
      Mod+A { spawn "${pkgs.rofi}/bin/rofi" "-show" "drun" "-show-icons" "-theme" "${rofiLauncher}"; }
      Mod+C { spawn "${pkgs.rofi}/bin/rofi" "-show" "calc" "-modi" "calc" "-no-show-match" "-no-sort" "-theme" "${rofiLauncher}"; }
      Mod+P { spawn "rofi-pass"; }
      Mod+V { spawn "clipmenu"; }
      Mod+BackSpace { spawn "${pkgs.rofi}/bin/rofi" "-show" "powermenu" "-modi" "powermenu:${pkgs.rofi-power-menu}/bin/rofi-power-menu" "-theme" "${rofiPower}"; }

      Mod+B { spawn "firefox"; }
      Mod+Shift+B { spawn "vivaldi"; }
      Mod+N { spawn "dunstctl" "history-pop"; }
      Mod+Shift+N { spawn "dunstctl" "close-all"; }
      Mod+Ctrl+N { spawn "obsidian"; }
      Mod+E { spawn "thunar"; }
      Mod+I { spawn "code"; }
      Mod+M { spawn "alacritty" "-e" "btop"; }
      Mod+G { spawn "io.github.alainm23.planify"; }
      Mod+Shift+X { spawn "gcolor3"; }
      Mod+Ctrl+X { spawn "xcolor" "-s"; }

      XF86AudioMute { spawn "pamixer" "-t"; }
      XF86AudioMicMute { spawn "pamixer" "--default-source" "-t"; }
      XF86AudioLowerVolume { spawn "pamixer" "-d" "5"; }
      XF86AudioRaiseVolume { spawn "pamixer" "-i" "5"; }
      XF86AudioPlay { spawn "playerctl" "play-pause"; }
      XF86AudioPause { spawn "playerctl" "play-pause"; }
      XF86AudioNext { spawn "playerctl" "next"; }
      XF86AudioPrev { spawn "playerctl" "previous"; }
      XF86MonBrightnessDown { spawn "brightnessctl" "set" "1%-"; }
      XF86MonBrightnessUp { spawn "brightnessctl" "set" "+1%"; }

      Print { screenshot; }
      Alt+Print { screenshot-screen; }
      Ctrl+Print { screenshot-window; }
    }
  '';
}