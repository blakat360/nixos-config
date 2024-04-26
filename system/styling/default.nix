{ pkgs, ... }:
let
  theme = "${pkgs.base16-schemes}/share/themes/solarized-dark.yaml";
  font = {
    name = "JetBrainsMonoNerdFontMono";
    package =
      (pkgs.nerdfonts.override {
        fonts = [ "JetBrainsMono" ];
      });
  };
in
{
  stylix = {
    image = ./wallpaper.png;
    base16Scheme = theme;

    autoEnable = true;

    fonts = {
      serif = font;
      sansSerif = font;
      monospace = font;

      sizes = {
        applications = 12;
        desktop = 13;
        terminal = 12;
      };
    };
  };
}






