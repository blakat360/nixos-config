{ config, pkgs, nix-colors, email, ... }:

{
  home.packages = with pkgs; [
    go
    gopls
    gofumpt
  ];
}
