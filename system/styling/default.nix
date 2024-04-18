{ pkgs, ... }:
let
  theme = "${pkgs.base16-schemes}/share/themes/solarized-dark.yaml";
in
{
  stylix = {
    image = ./wallpaper.png;
    base16Scheme = theme;

    autoEnable = true;

    fonts = {
      serif = {
        name = "Cantarell";
        package = pkgs.cantarell-fonts;
      };

      sansSerif = {
        name = "Cantarell";
        package = pkgs.cantarell-fonts;
      };

      monospace = {
        name = "Monoisome Regular";
        package = pkgs.monoid;
      };

      sizes = {
        applications = 11;
        desktop = 11;
        terminal = 12;
      };
    };

  };
}
