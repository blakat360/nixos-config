{ config, pkgs, nix-colors, email, isLinux, ... }:

let
  generated = import ./_sources/generated.nix { inherit (pkgs) fetchurl fetchgit fetchFromGitHub; };
  nix-colors-lib = nix-colors.lib-contrib { inherit pkgs; };
  OS-specific-imports = if isLinux then [ ] else [ ./kitty.nix ];
  OS-specific-services =
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
    ./kakoune
  ] ++ OS-specific-imports;

  home.packages = with pkgs; [
    bat
    comma
    direnv
    fd
    file
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
    fzf = {
      enable = true;
      tmux.enableShellIntegration = true;
    };
    skim = {
      enable = true;
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
    broot = {
      enable = true;
    };
    tmux = {
      enable = true;
      clock24 = true;
      shell = "${pkgs.fish}/bin/fish";
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
      extraConfig = with config.colorScheme.colors; ''
        set-option -g status-position top

        # default statusbar colors
        set-option -g status-style "fg=#${base04},bg=#${base01}"
       
        # default window title colors
        set-window-option -g window-status-style "fg=#${base04},bg=default"
       
        # active window title colors
        set-window-option -g window-status-current-style "fg=#${base0A},bg=default"
       
        # pane border
        set-option -g pane-border-style "fg=#${base01}"
        set-option -g pane-active-border-style "fg=#${base02}"
       
        # message text
        set-option -g message-style "fg=#${base05},bg=#${base01}"
       
        # pane number display
        set-option -g display-panes-active-colour "#${base0B}"
        set-option -g display-panes-colour "#${base0A}"
       
        # clock
        set-window-option -g clock-mode-colour "#${base0B}"
       
        # copy mode highligh
        set-window-option -g mode-style "fg=#${base04},bg=#${base02}"
       
        # bell
        set-window-option -g window-status-bell-style "fg=#${base01},bg=#${base08}"
      '';
    };
  };

  services = OS-specific-services;
}

