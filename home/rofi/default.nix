{ config, pkgs, ... }:
{
  imports = [ ./theme.nix ];
  programs.rofi = {
    enable = true;
    font = "FiraCode Nerd Font 15";
  };
}
