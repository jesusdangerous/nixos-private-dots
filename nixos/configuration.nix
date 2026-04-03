{ pkgs, inputs, user, ... }: {
  imports = [
    /etc/nixos/hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ../modules/nixos/bundle.nix
    ./packages.nix
  ];

  # Если какие-то сервисы кладут систему при ребилде,
  # то их ребут при ребилде можно выключить таким конфигом:
  # systemd.services = {
  #   "accounts-daemon".restartIfChanged = false;
  #   "home-manager-${user.username}".restartIfChanged = false;
  # };

  boot = {
    kernelPackages = pkgs.linuxPackages; # Стабильное ядро из текущего канала
    # kernelParams = [ # https://nixos.wiki/wiki/AMD_GPU#Dual_Monitors
    #   "video=1920x1080"
    # ];

    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev"; # nodev позволяет не устанавливать grub в конкретное место, но видеть его ui
      };
      efi.canTouchEfiVariables = true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;
    
    users.${user.username} = {
      isNormalUser = true;
      description = user.username;
      extraGroups = [ "networkmanager" "wheel" "input" "libvirtd" "storage" "docker" "video" "vboxusers" ];
      # packages = with pkgs; [
      #   clang-tools
      # ];
    };
  };

  home-manager = {
    # also pass inputs to home-manager modules
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; inherit user; };
    users.${user.username} = import ./home.nix;
  };

  security.polkit = { # Всплывающее меню для ввода пароля
    enable = true;
  };

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    # For nix-gaming
    substituters = ["https://nix-gaming.cachix.org"];
    trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
  };

  system.stateVersion = "24.05"; # Don't change it

}
