#TODO: change this to support base 16 colour schemes
{ config, pkgs, ... }:

{
  imports = [
    ./lsp.nix
  ];

  home.sessionVariables = {
    EDITOR="kak";
  };

  programs.kakoune = {
    enable = true;
    config = {
      showMatching = true;
      tabStop = 2;
      indentWidth = 2;
      colorScheme = "solarized-dark";
    };
  };
}
