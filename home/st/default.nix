{ config, pkgs, nix-colors, ... }:
{
  home.packages = with pkgs; [
    (st.overrideAttrs (oldAttrs: rec {
      configFile = pkgs.substituteAll (
        { src = ./config.h; } // config.colorScheme.colors
      );
      patches = [
        # support emojis/glyphs/unicode/et
        (fetchpatch {
          url = "https://st.suckless.org/patches/glyph_wide_support/st-glyph-wide-support-20220411-ef05519.diff";
          sha256 = "0rr5q54ag9j0zbq15mvzjxqkrna21jmabfghda3srbf6j4a92ac4";
        })
      ];
      postPatch = ''
        	${oldAttrs.postPatch}
        	cp ${configFile} config.def.h
      '';
    }))
  ];
}
