{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    rofi-power-menu
  ];

  programs.rofi = {
    enable = true;
    font = "FiraCode Nerd Font 15";
    theme = toString (pkgs.substituteAll (
      { src = ./theme.rasi; } // config.colorScheme.colors
    ));
  };
}
