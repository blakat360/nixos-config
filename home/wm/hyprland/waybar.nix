{ config, lib, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        modules-left = [ "hyprland/workspaces" "hyprland/mode" ];
        modules-center = [ "hyprland/window" ];
        modules-right = lib.lists.optional config.hasBattery [ "battery" ] ++ [ "clock" ];
        "hyprland/window" = {
          "max-length" = 50;
        };
        "battery" = {
          "format" = "{capacity}% {icon}";
          "format-icons" = [ "" "" "" "" "" ];
        };
        "clock" = {
          "format-alt" = "{=%a, %d. %b  %H=%M}";
        };
      };
    };
  };
}
