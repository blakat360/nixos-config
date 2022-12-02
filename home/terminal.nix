{ config, pkgs, nix-colors, ... }:

let
  generated = import ./_sources/generated.nix { inherit (pkgs) fetchurl fetchgit fetchFromGitHub; };
  nix-colors-lib = nix-colors.lib-contrib { inherit pkgs; };
in
{
  imports = [
    ./starship_settings.nix
    ./kakoune
    ./st
  ];

  home.packages = with pkgs; [
    bat
    fd
    file
    fzf
    git
    nerdfonts
    python3 # needed for bass fish plugin
    ripgrep
    starship
    tldr
    tree
    unzip
    wget
    xsel
  ];

  programs = {
    command-not-found.enable = false;
    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };
    starship = {
      enable = true;
    };
    git = {
      enable = true;
      aliases = {
        s = "status";
        d = "diff";
      };
      delta = {
        enable = true;
        options = { navigate = true; light = false; };
      };
      extraConfig = {
        user.email = "blakat360@gmail.com";
        add.interactive.useBuiltin = false;
        merge.conflictstyle = "diff3";
        diff.colorMoved = "default";
        init.defaultBranch = "master";
      };
    };
    fish = {
      enable = true;
      shellAliases = {
        bm = "bashmount";
        mv = "mv -i";
      };
      functions = {
        fish_user_key_bindings = ''
          	  bind --mode default ' ' execute
          	'';
      };
      plugins = with generated; [
        { name = getopts.pname; src = getopts.src; }
        { name = "grc"; src = pkgs.fishPlugins.grc.src; }
        { name = "bass"; src = pkgs.fishPlugins.bass.src; }
        { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
      ];
      interactiveShellInit = ''
        fish_vi_key_bindings
        sh ${nix-colors-lib.shellThemeFromScheme { scheme = config.colorScheme; }}
      '';
    };
    zoxide.enable = true;
    tmux = {
      enable = true;
      clock24 = true;
    };
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
}

