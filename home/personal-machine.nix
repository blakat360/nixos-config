{ pkgs, ... }:

{
  imports = [
    ./discord.nix
    ./wm/i3.nix
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

  };


  services = {
    betterlockscreen = {
      enable = true;
    };
    screen-locker = {
      enable = true;
      xautolock.enable = false;
    };
  };
}
