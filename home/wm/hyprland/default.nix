{ pkgs, isNvidia, ... }: {

  home.packages = with pkgs; [ qt6.wayland ];
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
}
