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
      # need to update before enabling - quickmenu # ez vm setup
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
