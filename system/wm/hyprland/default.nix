{ config, lib, ... }: {
  imports = [ ./greeter.nix ];

  programs.hyprland = {
    xwayland.enable = true;
    enable = true;
  };

  xdg.portal.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  } // lib.attrsets.optionalAttrs config.isNvidia {
    "LIBVA_DRIVER_NAME" = "nvidia";
    "XDG_SESSION_TYPE" = "wayland";
    "GBM_BACKEND" = "nvidia-drm";
    "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
    "WLR_NO_HARDWARE_CURSORS" = "1";
  };
}


