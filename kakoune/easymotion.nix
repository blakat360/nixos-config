{ config, pkgs, ... }:

{
  programs.kakoune = {
    plugins = with pkgs.kakounePlugins; [ kakoune-easymotion ];
    extraConfig = ''
      map global normal f :easy-motion-f<ret>
      map global normal <a-f> :easy-motion-alt-f<ret>
    '';
  };
  
}
