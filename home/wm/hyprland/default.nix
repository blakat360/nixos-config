{ pkgs, isNvidia, ... }: {

  home.packages = with pkgs; [
    libsForQt5.dolphin
    qt6.wayland
  ];
  programs = {
    xdg.portal.enable = true;
    wofi.enable = true;
    waybar.enable = true;
    dunst.enable = true;
  };
  wayland.windowManager.hyprland = {
    enable = true;
    enableNvidiaPatches = isNvidia;
    systemd.variables = [ "--all" ];
  };

  xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
}
