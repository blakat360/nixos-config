{ config, pkgs, ... }:

{
  imports = [
    ./discord.nix
    ./wm/hyprland
    ./rofi
  ];

  home = {
    packages = with pkgs; [
      anki
      bashmount
      brightnessctl
      chromium
      firefox
      pamixer
      rofi-bluetooth
      steam
      vhs
      xsel
      zoom-us
    ];

    sessionVariables = {
      GDK_SCALE = 1;
      GDK_DPI_SCALE = 0.75;
      QT_AUTO_SCREEN_SCALE_FACTOR = 1;
      QT_AUTO_SCREEN_SET_FACTOR = 0;
    };
  };
}
