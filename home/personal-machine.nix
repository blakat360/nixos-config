{ config, pkgs, ... }:

{
  imports = [
    ./wm/i3.nix
    ./rofi
    ./st
  ];

  home.packages = with pkgs; [
    anki
    bashmount
    brightnessctl
    pamixer
    rofi-bluetooth
    steam
    vhs
    xsel
  ];

  services = {
    betterlockscreen = {
      enable = true;
      arguments = ["--color ${config.colorScheme.colors.base00}"];
    };
    screen-locker = {
      enable = true;
      xautolock.enable = false;
    };
  };
}
