{ config, pkgs, nix-colors, ... }:
let
  font = "FiraCode Nerd Font Mono";
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      "font" = {
        "size" = 17;
        "normal" = { "family" = font; "style" = "Regular"; };
        "bold" = { "family" = font; "style" = "Bold"; };
        "italic" = { "family" = font; "style" = "Light, Regular"; };
        "bold_italic" = { "family" = font; "style" = "SemiBold, Regular"; };
        "key_bindings" = [
          {
            key = "Key0";
            mods = "Alt";
            chars = "\x1b0";
          }
          { key = "Key1"; mods = "Alt"; chars = "\x1b1"; }
          { key = "Key2"; mods = "Alt"; chars = "\x1b2"; }
          { key = "Key3"; mods = "Alt"; chars = "\x1b3"; }
          { key = "Key4"; mods = "Alt"; chars = "\x1b4"; }
          { key = "Key5"; mods = "Alt"; chars = "\x1b5"; }
          { key = "Key6"; mods = "Alt"; chars = "\x1b6"; }
          { key = "Key7"; mods = "Alt"; chars = "\x1b7"; }
          { key = "Key8"; mods = "Alt"; chars = "\x1b8"; }
          { key = "Key9"; mods = "Alt"; chars = "\x1b9"; }
        ];
      };
    };
  };
}

# FiraCode Nerd Font Mono:style=Medium,Regular
# FiraCode Nerd Font Mono:style=Light,Regular
# FiraCode Nerd Font Mono:style=Regular
# FiraCode Nerd Font Mono:style=SemiBold,Regular
# FiraCode Nerd Font Mono:style=Bold
# FiraCode Nerd Font Mono:style=Retina,Regular
