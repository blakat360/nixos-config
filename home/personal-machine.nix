{ config, pkgs, ... }:

{
  imports = [
    ./wm/i3.nix
    ./rofi
    ./st
  ];

  home = {
    packages = with pkgs; [
      anki
      bashmount
      brightnessctl
      pamixer
      rofi-bluetooth
      steam
      vhs
      xsel
    ];

    sessionVariables = {
      GDK_SCALE = 1;
      GDK_DPI_SCALE = 0.75;
      QT_AUTO_SCREEN_SCALE_FACTOR = 1;
      QT_AUTO_SCREEN_SET_FACTOR = 0;
    };
  };


  services = {
    betterlockscreen = {
      enable = true;
      arguments = [ "--color ${config.colorScheme.colors.base00}" ];
    };
    screen-locker = {
      enable = true;
      xautolock.enable = false;
    };
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };
  };
}
