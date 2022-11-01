# TODO: notification when low power
# TODO: look into configuring TLP
# TODO: set up a nice way to include this in some configs (laptop ones), and not others (perhaps multiple flakes, one for each type of system I plan to provision?)
{config, pkgs, ...}:

{
  # battery management
  services = {
    tlp.enable = true;
    power-profiles-daemon.enable = false;
  };
}
