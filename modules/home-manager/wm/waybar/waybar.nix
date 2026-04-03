{ pkgs, config, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        margin = "0 0 0 0";
        modules-left = [ "niri/workspaces" ];
        modules-center = [ "niri/window" ];
        modules-right = [ "niri/language" "pulseaudio" "clock" ];

        "niri/workspaces" = {
          format = "{icon}";
          format-icons = {
            active = "󰊢";
            default = "󰊠";
            empty = "󰲡";
            focused = "󰊢";
            urgent = "󰲭";
          };
        };

        "niri/window" = {
          format = "{title}";
          max-length = 50;
        };

        "niri/language" = {
          format = "  {short}";
        };

        clock = {
          format = "  {:%H:%M}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          format-muted = "󰝟  {volume}%";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          on-click = "pavucontrol";
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: monospace;
        font-size: 13px;
        min-height: 30px;
      }

      window#waybar {
        background-color: #${config.lib.stylix.colors.base00};
        border-bottom: 1px solid #${config.lib.stylix.colors.base01};
        color: #${config.lib.stylix.colors.base05};
      }

      #workspaces button {
        padding: 0 10px;
        color: #${config.lib.stylix.colors.base05};
        background-color: transparent;
        border-bottom: 2px solid transparent;
      }

      #workspaces button.active,
      #workspaces button.focused {
        color: #${config.lib.stylix.colors.base0D};
        border-bottom-color: #${config.lib.stylix.colors.base0D};
      }

      #workspaces button.urgent {
        color: #${config.lib.stylix.colors.base08};
      }

      #window {
        padding: 0 20px;
        color: #${config.lib.stylix.colors.base05};
      }

      #language {
        padding: 0 10px;
        color: #${config.lib.stylix.colors.base0D};
      }

      #clock {
        padding: 0 10px;
        color: #${config.lib.stylix.colors.base05};
      }

      #pulseaudio {
        padding: 0 10px;
        color: #${config.lib.stylix.colors.base0B};
      }

      #pulseaudio.muted {
        color: #${config.lib.stylix.colors.base08};
      }
    '';
  };

  home.packages = with pkgs; [ waybar ];
}
