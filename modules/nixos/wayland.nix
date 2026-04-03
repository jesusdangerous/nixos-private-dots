{ pkgs, ... }: {
  programs = {
    niri = {
      enable = true;
      useNautilus = false;
    };

    xwayland.enable = true;
  };

  services.displayManager = {
    defaultSession = "niri";
    sddm = {
      enable = true;
      theme = "chili";
    };
  };

  services.libinput = {
    enable = true;
    mouse = {
      accelProfile = "flat";
      scrollMethod = "button";
      scrollButton = 9;
      middleEmulation = false;
    };
    touchpad = {
      accelProfile = "flat";
      middleEmulation = false;
    };
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];

    xkb = {
      layout = "us,ru";
      variant = "";
      options = "grp:caps_toggle";
    };
  };

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
  };
}