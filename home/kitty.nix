{ config, pkgs, nix-colors, ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font Mono";
      size = 17;
    };
    settings = {
      "macos_option_as_alt" = "yes";
    };
  };
}

# FiraCode Nerd Font Mono:style=Medium,Regular
# FiraCode Nerd Font Mono:style=Light,Regular
# FiraCode Nerd Font Mono:style=Regular
# FiraCode Nerd Font Mono:style=SemiBold,Regular
# FiraCode Nerd Font Mono:style=Bold
# FiraCode Nerd Font Mono:style=Retina,Regular
