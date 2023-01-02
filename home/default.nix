#TODO: find a way to grab the exec command from the active window manager
#      perhaps define a 'name' attr or smthng to grab
{ config, pkgs, nix-colors, ... }:

{
  imports = [
    ./wm/i3.nix
    ./discord.nix
    ./terminal.nix
    ./rofi
    nix-colors.homeManagerModule
  ];

  colorScheme = nix-colors.colorSchemes.solarized-dark;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "sigkill";
    homeDirectory = "/home/sigkill";

    sessionVariables = {
      GDK_SCALE = 1;
      GDK_DPI_SCALE = 0.75;
      QT_AUTO_SCREEN_SCALE_FACTOR = 1;
      QT_AUTO_SCREEN_SET_FACTOR = 0;
    };
  };

  gtk.theme.package = nix-colors.lib-contrib.gtkThemeFromScheme {
    scheme = config.colorScheme;
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
    rofi-bluetooth
    steam
    vhs
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
  };

  services = {
    betterlockscreen.enable = true;
    screen-locker = {
      enable = true;
    };
  };
}
