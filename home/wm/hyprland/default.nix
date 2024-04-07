{
  inputs = [ ./greeter.nix ];
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.variables = [ "--all" ];
  };
}
