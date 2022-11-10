{config, pkgs, ...}:

let
  generated = import ./_sources/generated.nix {inherit (pkgs) fetchurl fetchgit fetchFromGitHub; };
in
{
  imports = [
    ./starship_settings.nix
    ./kakoune
  ];
  
  home.packages = with pkgs; [
    st
    bat
    fd
    fish
    fzf
    git
    python3 # needed for bass plugin
    ripgrep
    starship
    tldr
    tree
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
	options = {navigate = true; light = false;};
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
    };
    zoxide.enable = true;
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
}
