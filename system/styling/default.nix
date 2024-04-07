{ pkgs, ... }:
let
  firacode = pkgs.fira-code-nerdfont;
  theme = "${pkgs.base16-schemes}/share/themes/solarized-dark.yaml";
  size = if pkgs.stdenv.isLinux then 12 else 16;
in
{
  stylix = {
    image = ./wallpaper.png;
    base16Scheme = theme;

    autoEnable = true;
    fonts = {
      serif = {
        package = firacode;
        name = "Fira Code Regular Nerd Font Complete";
      };

      sansSerif = {
        package = firacode;
        name = "Fira Code Regular Nerd Font Complete";
      };

      monospace = {
        package = firacode;
        name = "Fira Code Regular Nerd Font Complete Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        terminal = size;
      };
    };

  };
}
