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
      quickemu # ez vm setup
      rofi-bluetooth
      obsidian
      steam
      wf-recorder
      vhs
      xsel
      xournalpp
      zoom-us
    ];

  };
}
