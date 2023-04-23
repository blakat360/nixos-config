{ config, pkgs, nix-colors, mach-nix, ... }:

{
  home.packages = with pkgs; [
    jupyter
    # mach-nix
  ];
}
