{ config, pkgs, lib, ... }:

let
  generated = import ./_sources/generated.nix { inherit (pkgs) fetchurl fetchgit fetchFromGitHub; };
  OS-specific-services = with pkgs.stdenv;
    if isLinux then {
      gpg-agent = {
        enable = true;
        defaultCacheTtl = 1800;
        enableSshSupport = true;
      };
    } else { };
in
{
  imports = [
    ./starship_settings.nix
    ./kitty.nix
    ./editor
    ./languages
  ];

  home.packages = with pkgs; [
    bat
    comma
    direnv
    dig
    dust
    fd
    file
    grc
    helix
    htop-vim
    inetutils
    jq
    libiconvReal
    mutt
    parallel
    pup
    python3
    qemu
    ripgrep
    sd
    starship
    termshark
    tldr
    tree
    unzip
    wget
    wireshark
    zathura
    zip
  ];

  home.sessionVariables = {
    "SHELL" = "fish";
  };

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
        user.email = lib.mkIf (config ? email) config.email;
        add.interactive.useBuiltin = false;
        merge.conflictstyle = "diff3";
        diff.tool = "delta";
        diff.colorMoved = "default";
        init.defaultBranch = "master";
      };
    };
    gpg = {
      enable = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    fzf = {
      enable = true;
      tmux.enableShellIntegration = true;
    };
    skim = {
      enable = true;
    };
    eza = {
      enable = true;
      enableFishIntegration = true;
      icons = "auto";
      git = true;
    };
    fish = {
      enable = true;
      shellAliases = {
        bm = "bashmount";
        mv = "mv -i";
        lg = "lazygit";
        e = "$EDITOR";
      };
      functions = {
        fish_user_key_bindings = ''
          	  bind --mode default ' ' execute
        '';
        fish_greeting = ''
          	set options "(⚈∇⚈ )" "(✿╹◡╹)" "/ᐠ. ᴗ.ᐟ\\" "/ᐠ.ꞈ.ᐟ\\" "/ᐠ_ ꞈ _ᐟ\\"; echo (shuf -n 1 -e $options)
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
      '';
    };
    zoxide.enable = true;
    broot = {
      enable = true;
    };
    lazygit.enable = true;
    tmux = {
      enable = true;
      clock24 = true;
      shortcut = "a";
      terminal = "screen-256color";
      escapeTime = 0;
      baseIndex = 1;
      sensibleOnTop = true;
      tmuxinator.enable = true;
      plugins = with pkgs.tmuxPlugins; [
        yank
        prefix-highlight
        better-mouse-mode
        extrakto
        pain-control
      ];
    };
  };

  services = OS-specific-services;
}

