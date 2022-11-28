{ config, pkgs, lib, ... }:

{
  xsession.enable = true;
  xsession.windowManager.i3 = {
    enable = true;
    config = rec {
      terminal = "st";
      modifier = "Mod4";
      menu = "rofi -show run";
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
      };
    };
  };
}
