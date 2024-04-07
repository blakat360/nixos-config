{ pkgs, ... }:
{
  home.packages = with pkgs; [
    rofi-power-menu
  ];

  programs.rofi = {
    enable = true;
  };
}
