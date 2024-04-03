{ config, pkgs, nix-colors, email, ... }:

{
  home.packages = with pkgs; [
    rustup
  ];

  xdg.configFile."rustfmt/rustfmt.toml".text = ''
  	tab_spaces = 2
  '';
}
