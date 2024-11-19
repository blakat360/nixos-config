{ pkgs, config, ... }:
{

  # needed for emacs from src
  home.packages = with pkgs; [
    autoconf
    pkg-config
    libwebp
    librsvg
    sqlite
    sqlite.dev
    gtk3
    libgccjit

    source-code-pro # spacemacs font
  ];
}
