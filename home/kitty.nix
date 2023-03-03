{ config, pkgs, nix-colors, ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font Mono";
      size = if pkgs.stdenv.isLinux then 12 else 17;
    };
    settings = {
      "macos_option_as_alt" = "yes";
      "shell" = "fish";
    };
  };
}

# FiraCode Nerd Font Mono:style=Medium,Regular
# FiraCode Nerd Font Mono:style=Light,Regular
# FiraCode Nerd Font Mono:style=Regular
# FiraCode Nerd Font Mono:style=SemiBold,Regular
# FiraCode Nerd Font Mono:style=Bold
# FiraCode Nerd Font Mono:style=Retina,Regular
