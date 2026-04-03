{ pkgs, config, ... }:
{
  systemd.user.services.swaybg = {
    Unit = {
      Description = "Wallpaper daemon for Wayland";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session-pre.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.swaybg}/bin/swaybg -i ${config.home.homeDirectory}/.config/wallpapers/nix-glow-gruvbox.jpg";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  home.packages = with pkgs; [ swaybg ];

  # Копируем обои в .config/wallpapers
  home.file.".config/wallpapers/nix-glow-gruvbox.jpg".source = ../../nixos/nix-glow-gruvbox.jpg;
}
