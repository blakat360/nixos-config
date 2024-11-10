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
      heroic
      pamixer
      rofi-bluetooth
      steam
      shotcut
      vhs
      xsel
      xournalpp
      zoom-us
    ];

  };
}
