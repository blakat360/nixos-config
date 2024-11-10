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
  wallpaper = pkgs.runCommand "image.png" { } ''
    COLOR=$(${pkgs.yq}/bin/yq -r .palette.base00 ${theme})
    echo ${theme}
    COLOR="#"$COLOR
    ${pkgs.imagemagick}/bin/magick -size 1920x1080 xc:$COLOR $out
  '';
in
{
  stylix = {
    enable = true;
    image = wallpaper;

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






