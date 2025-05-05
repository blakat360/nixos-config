{ pkgs, ... }:

{
  imports = [
    ./discord.nix
    ./pentesting.nix
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
      quickemu # ez vm setup
      rofi-bluetooth
      obsidian
      steam
      vhs
      xsel
      xournalpp
      zoom-us
    ];

  };
}
