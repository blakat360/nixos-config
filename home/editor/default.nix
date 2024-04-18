{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    nil # nix lsp
    nixpkgs-fmt # nix formatter
  ];

  home.sessionVariables = {
    EDITOR = "hx";
  };

  stylix.targets.helix.enable = false;

  programs.helix = {
    enable = true;
    settings = {
      theme = "nix-theme";
      editor = {
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        file-picker.hidden = false;
        soft-wrap.enable = true;
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
        statusline.left = [ "mode" "spinner" "file-name" "version-control" ];
        cursorline = true;
      };
      keys.normal.esc = [ "collapse_selection" "keep_primary_selection" ];
    };
  };

  xdg.configFile."helix/languages.toml".source = ./languages.toml;

  xdg.configFile."helix/themes/nix-theme.toml".text = import ./theme.nix { inherit config; };
}
