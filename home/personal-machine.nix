{ pkgs, ... }:

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
      shotcut
      vhs
      xsel
      zoom-us
    ];

  };
}
