{ config, pkgs, nix-colors, ... }:
let
	colors = config.colorScheme.colors;
	color_file = ''
		/* Terminal colors (16 first used in escape sequence) */
    static const char *colorname[] = {

      /* 8 normal colors */
      [0] = "#${colors.base00}",
      [1] = "#${colors.base01}",
      [2] = "#${colors.base02}",
      [3] = "#${colors.base03}",
      [4] = "#${colors.base04}",
      [5] = "#${colors.base05}",
      [6] = "#${colors.base06}",
      [7] = "#${colors.base07}",

      /* 8 bright colors */
      [8]  = "#${colors.base08}",
      [9]  = "#${colors.base09}",
      [10] = "#${colors.base0A}",
      [11] = "#${colors.base0B}",
      [12] = "#${colors.base0C}",
      [13] = "#${colors.base0D}",
      [14] = "#${colors.base0E}",
      [15] = "#${colors.base0F}",

      /* special colors */
      [256] = "#${colors.base00}", /* background */
      [257] = "#${colors.base05}", /* foreground */
    };

    /*
     * Default colors (colorname index)
     * foreground, background, cursor, reverse cursor
     */
    unsigned int defaultfg = 257;
    unsigned int defaultbg = 256;
    unsigned int defaultcs = 257;
    static unsigned int defaultrcs = 257;

    /*
     * Colors used, when the specific fg == defaultfg. So in reverse mode this
     * will reverse too. Another logic would only make the simple feature too
     * complex.
     */
    static unsigned int defaultitalic = 7;
    static unsigned int defaultunderline = 7;
	'';
in
{
	home.packages = with pkgs; [
    (st.overrideAttrs (oldAttrs: rec {
      configFile = writeText "config.def.h" (builtins.readFile ./config.h);
      postPatch = ''
      	${oldAttrs.postPatch}
      	cp ${configFile} config.def.h
      	echo '${color_file}' > colors.h
     '';
    }))
	];
}
