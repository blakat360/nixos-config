{ lib, ... }:
{
  xsession.enable = true;
  xsession.windowManager.i3 = {
    enable = true;
    config = rec {
      terminal = "kitty";
      modifier = "Mod4";
      menu = "rofi -show drun";
      defaultWorkspace = "workspace number 1";
      keybindings = lib.mkOptionDefault {
        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";

        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";

        "${modifier}+|" = "split v";
        "${modifier}+-" = "split h";

        # power menu - locking works with loginctl
        "${modifier}+Escape" = "exec rofi -show power-menu -modi power-menu:rofi-power-menu";
        # bluetooth menu
        "${modifier}+b" = "exec rofi-bluetooth";

        "XF86AudioRaiseVolume" = "exec --no-startup-id pamixer --increase 10";
        "XF86AudioLowerVolume" = "exec --no-startup-id pamixer --decrease 10";
        "XF86AudioMute" = "exec --no-startup-id pamixer --toggle-mute";

        "XF86MonBrightnessUp" = "exec --no-startup-id brightnessctl set +10%";
        "XF86MonBrightnessDown" = "exec --no-startup-id brightnessctl set 10%-";
      };
    };
  };
}
