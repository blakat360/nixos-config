{ config, pkgs, ... }: {

  home.packages = with pkgs; [
    libsForQt5.dolphin
    qt6.qtwayland
  ];

  programs = {
    wofi.enable = true;
    waybar.enable = true;
  };

  services = {
    dunst.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
  };
}
