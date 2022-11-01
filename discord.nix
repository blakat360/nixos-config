{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ (discord.override { withOpenASAR = true; nss = pkgs.nss_latest; }) ];
  xdg.configFile."discord/settings.json".text = ''
    {
      "SKIP_HOST_UPDATE": true
    }
  '';
}
