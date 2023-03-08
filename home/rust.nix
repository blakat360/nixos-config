{ config, pkgs, nix-colors, email, ... }:

{
  home.packages = with pkgs; [
    rustup
    rnix-lsp
    rust-analyzer
  ];

  xdg.configFile."rustfmt/rustfmt.toml".text = ''
  	tab_spaces = 2
  '';
}
