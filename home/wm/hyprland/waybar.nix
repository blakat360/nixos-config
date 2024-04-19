{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    pavucontrol
    blueberry
    networkmanagerapplet
  ];
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        modules-left = [ "hyprland/workspaces" "hyprland/mode" ];
        modules-center = [ "hyprland/window" ];
        modules-right = lib.lists.optional config.hasBattery "battery" ++
          [
            "wireplumber"
            "idle_inhibitor"
            "bluetooth"
            "network"
            "clock"
          ];
        "hyprland/window" = {
          "max-length" = 50;
        };
        "battery" = {
          "format" = "{icon} {capacity}%";
          "format-icons" = [ "" "" "" "" "" ];
        };
        "clock" = {
          "tooltip" = true;
          "format" = " {:%H.%M}";
          "tooltip-format" = "󰃭 {:%Y-%m-%d}";
        };
        "network" = {
          "interface" = "wlp2s0";
          "format" = "{ifname}";
          "format-wifi" = " {essid} ({signalStrength}%)";
          "format-ethernet" = " {ifname}";
          "format-disconnected" = "󰖪"; # An empty format will hide the module.
          "tooltip-format" = "{ifname}";
          "tooltip-format-wifi" = "  {essid} ({signalStrength}%)";
          "tooltip-format-ethernet" = " {ifname}";
          "tooltip-format-disconnected" = "Disconnected";
          "max-length" = 50;
          "on-click" = "nm-connection-editor";
        };
        "idle_inhibitor" = {
          "format" = "{icon}";
          "format-icons" = {
            "activated" = " idle_blocked";
            "deactivated" = " ";
          };
          "timeout" = 30.5; # minutes before reset
        };
        "bluetooth" = {
          "format" = "󰂯 {status}";
          "format-connected" = "󰂯 {device_alias}";
          # "format-connected-battery" = "   {device_alias} {device_battery_percentage}%";
          # "format-device-preference" = [ "device1"; "device2" ]; // preference list deciding the displayed device
          "tooltip-format" = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          "tooltip-format-connected" = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          "tooltip-format-enumerate-connected" = "{device_alias}\t{device_address}";
          "tooltip-format-enumerate-connected-battery" = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
          "on-click" = "blueberry";
        };
        "wireplumber" = {
          "format" = " {volume}%";
          "format-muted" = "";
          "on-click" = "pavucontrol";
        };
      };
    };
  };
}


