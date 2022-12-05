{ config, pkgs, nix-colors, ... }:
let
	color_file = with config.colorScheme.colors; ''
		/* Terminal colors (16 first used in escape sequence) */
    static const char *colorname[] = {

      /* 8 normal colors */
      [0] = "#${base00}",
      [1] = "#${base01}",
      [2] = "#${base02}",
      [3] = "#${base03}",
      [4] = "#${base04}",
      [5] = "#${base05}",
      [6] = "#${base06}",
      [7] = "#${base07}",

      /* 8 bright colors */
      [8]  = "#${base08}",
      [9]  = "#${base09}",
      [10] = "#${base0A}",
      [11] = "#${base0B}",
      [12] = "#${base0C}",
      [13] = "#${base0D}",
      [14] = "#${base0E}",
      [15] = "#${base0F}",

      /* special colors */
      [256] = "#${base00}", /* background */
      [257] = "#${base05}", /* foreground */
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
      patches = [
      	# support emojis/glyphs/unicode/et
      	( fetchpatch {
        	url = "https://st.suckless.org/patches/glyph_wide_support/st-glyph-wide-support-20220411-ef05519.diff";
        	sha256 = "0rr5q54ag9j0zbq15mvzjxqkrna21jmabfghda3srbf6j4a92ac4";
      	})
      ];
      postPatch = ''
      	${oldAttrs.postPatch}
      	cp ${configFile} config.def.h
      	echo '${color_file}' > colors.h
     '';
    }))
	];
}
