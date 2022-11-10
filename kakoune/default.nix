#TODO: change this to support base 16 colour schemes
{ config, pkgs, ... }:

{
  imports = [
  ];

  home.sessionVariables = {
    EDITOR="kak";
  };

  home.packages = with pkgs; [
    kakoune
  ];

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
