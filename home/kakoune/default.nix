#TODO: change this to support base 16 colour schemes
{ config, pkgs, ... }:

{
  imports = [
    ./fuzzy-finder.nix
    ./lsp.nix
    ./theme.nix
  ];

  home.sessionVariables = {
    EDITOR = "kak";
  };

  programs.kakoune = {
    enable = true;
    config = {
      showMatching = true;
      tabStop = 2;
      indentWidth = null; # use tab (needed for makefiles)
      ui.assistant = "cat";
      numberLines.enable = true;
    };
    extraConfig = ''
      map global normal "/" "/(?i)"

      map global goto <left> h
      map global goto <down> j
      map global goto <up> k
      map global goto <right> l
    '';
  };
}
