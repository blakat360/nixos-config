{ config, pkgs, ... }: {

  imports = [
    ./lock.nix
  ];

  home.packages = with pkgs;
    [
      libsForQt5.dolphin
      qt6.qtwayland
      libnotify
      polkit-kde-agent
      wl-clipboard
      hyprpicker # colour picker
    ];

  programs = {
    wofi.enable = true;
    waybar.enable = true;
  };

  services = {
    dunst.enable = true;
  };

  wayland.windowManager.hyprland =
    {
      enable = true;
      systemd = {
        variables = [ "--all" ];
        # runs on startup
        extraCommands = [
          "hypridle"
          "waybar"
        ];
      };

      settings = import ./settings.nix;
    };
}


