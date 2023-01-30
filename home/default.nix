#TODO: find a way to grab the exec command from the active window manager
#      perhaps define a 'name' attr or smthng to grab
{ config, pkgs, nix-colors, user, ... }:

{
  imports = [
    ./discord.nix
    ./terminal.nix
    nix-colors.homeManagerModule
  ] ++ (if user == "sigkill" then [ ./personal-machine.nix ] else [ ]);

  colorScheme = nix-colors.colorSchemes.solarized-dark;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

  };

  gtk.theme.package = nix-colors.lib-contrib.gtkThemeFromScheme {
    scheme = config.colorScheme;
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    chromium
    firefox
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
}
