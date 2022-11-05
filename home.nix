{ config, pkgs, ... }:

let
  generated = import ./_sources/generated.nix {inherit (pkgs) fetchurl fetchgit fetchFromGitHub; };
in
{
  imports = [ 
    ./starship_settings.nix 
    ./discord.nix
  ];
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "sigkill";
  home.homeDirectory = "/home/sigkill";
  
  home.sessionVariables = {
    EDITOR="kak";
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    bat
    fd
    firefox
    fish
    fzf
    git
    kakoune
    neovim
    ripgrep
    starship
    tldr
    tree
    xsel
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

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
      plugins = with generated; [ 
        { name = getopts.pname; src = getopts.src; }
        { name = z.pname; src = z.src; }
        { name = "grc"; src = pkgs.fishPlugins.grc.src; }
        { name = "bass"; src = pkgs.fishPlugins.bass.src; }
        { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
      ];
    };
 };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
}
