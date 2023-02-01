{ config, pkgs, nix-colors, email, isLinux, ... }:

let
  generated = import ./_sources/generated.nix { inherit (pkgs) fetchurl fetchgit fetchFromGitHub; };
  nix-colors-lib = nix-colors.lib-contrib { inherit pkgs; };
  OS-specific-imports = if isLinux then [] else [ ./alacritty.nix ];
  OS-specific-services = if isLinux then {
    gpg-agent = { enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };
  } else {};
in
{
  imports = [
    ./starship_settings.nix
    ./kakoune
  ] ++ OS-specific-imports;

  home.packages = with pkgs; [
    bat
    comma
    direnv
    fd
    file
    fzf
    git
    grc
    nerdfonts
    # lsp support and bass fish plugin
    (python3.withPackages (p: with p; [ python-lsp-server ]))
    ripgrep
    starship
    tldr
    tree
    unzip
    wget
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
        user.email = "${email}";
        add.interactive.useBuiltin = false;
        merge.conflictstyle = "diff3";
        diff.colorMoved = "default";
        init.defaultBranch = "master";
      };
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
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

  services = OS-specific-services;
}

