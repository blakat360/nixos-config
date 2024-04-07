{ ... }: {
  imports = [ ./greeter.nix ];

  programs.hyprland = {
    xwayland.enable = true;
    enable = true;
  };

  xdg.portal.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

}
