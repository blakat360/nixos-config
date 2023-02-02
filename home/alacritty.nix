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
