#TODO: find a way to grab the exec command from the active window manager
#      perhaps define a 'name' attr or smthng to grab
{ config, pkgs, ... }:

{
  imports = [
    ./wm/i3.nix
    ./discord.nix
    ./terminal.nix
  ];
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "sigkill";
  home.homeDirectory = "/home/sigkill";

  home.sessionVariables = {
    GDK_SCALE = 1;
    GDK_DPI_SCALE = 0.75;
    QT_AUTO_SCREEN_SCALE_FACTOR = 1;
    QT_AUTO_SCREEN_SET_FACTOR=0;
  };

# Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    anki
    bashmount
    brightnessctl
    chromium
    firefox
    libqalculate
    pamixer
    steam
    zoom-us
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
  programs = {
    home-manager.enable = true;
    rofi = {
      enable = true;
      theme = "solarized";
    };
  };
}
