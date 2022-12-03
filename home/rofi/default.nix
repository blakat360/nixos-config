{ config, pkgs, ... }:
{
  imports = [ ./theme.nix ];

  home.packages = with pkgs; [
    rofi-power-menu
  ];

  programs.rofi = {
    enable = true;
    font = "FiraCode Nerd Font 15";
  };
}
