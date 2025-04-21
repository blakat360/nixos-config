{ pkgs, ... }:
let
  theme = "${pkgs.base16-schemes}/share/themes/solarized-dark.yaml";
  font = {
    name = "JetBrainsMonoNerdFontMono";
    package = pkgs.nerd-fonts.jetbrains-mono;
  };
  wallpaper = pkgs.runCommand "image.png" { } ''
    COLOR=$(${pkgs.yq}/bin/yq -r .palette.base00 ${theme})
    ${pkgs.imagemagick}/bin/magick -size 1920x1080 xc:$COLOR $out
  '';
in
{
  stylix = {
    enable = true;
    image = wallpaper;

    base16Scheme = theme;

    autoEnable = true;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

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






