{ config, pkgs, ... }:
let
  powermenu = pkgs.writeShellScriptBin "powermenu" ''
    # Launching wofi with options "shutdown" and "lock"
    chosen_option=$(echo -e "shutdown\nlock" | ${pkgs.wofi}/bin/wofi --dmenu)

    # Switch case statement to handle chosen options
    case $chosen_option in
        "shutdown")
            shutdown now
            ;;
        "lock")
            ${pkgs.hyprlock}/bin/hyprlock
            ;;
        *)
            echo "Invalid option"
            ;;
    esac

  '';
in
{

  imports = [
    ./lock.nix
    ./waybar.nix
  ];

  home.packages = with pkgs;
    [
      libsForQt5.dolphin
      qt6.qtwayland
      libnotify
      polkit-kde-agent
      wl-clipboard
      hyprpicker # colour picker
      hyprshot
      powermenu
    ];

  programs = {
    wofi.enable = true;
  };

  services = {
    dunst.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = import ./settings.nix;
  };

}


