{ pkgs, config, ... }:
{
  home.packages = with pkgs; [ swaybg ];

  # Копируем обои в .config/wallpapers
  home.file.".config/wallpapers/nix-glow-gruvbox.jpg".source = ../../nixos/nix-glow-gruvbox.jpg;

  # Запускаем swaybg через systemd при старте графической сессии
  systemd.user.services.swaybg = {
    Unit = {
      Description = "Set wallpaper with swaybg";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
      Wants = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.swaybg}/bin/swaybg -i ${config.home.homeDirectory}/.config/wallpapers/nix-glow-gruvbox.jpg";
      Restart = "always";
      RestartSec = 1;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
