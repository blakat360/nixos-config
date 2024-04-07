#TODO: find a way to grab the exec command from the active window manager
#      perhaps define a 'name' attr or smthng to grab
{ pkgs, user, ... }:

{
  imports = [
    ./terminal.nix
    ./editor
  ] ++ (if user == "sigkill" then [ ./personal-machine.nix ] else [ ]);

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "${user}";
    homeDirectory = with pkgs.stdenv; if isLinux then "/home/${user}" else "/Users/${user}";
  };


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
