{ config, pkgs, nix-colors, ... }:
let
  font = "FiraCode NF";
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      "font" = {
        "size" = 17;
        "normal" = { "family" = font; "style" = "normal"; };
        "bold" = { "family" = font; "style" = "Bold"; };
        "italic" = { "family" = font; "style" = "Italic"; };
        "bold_italic" = { "family" = font; "style" = "Bold Italic"; };
      };
    };
  };
}
