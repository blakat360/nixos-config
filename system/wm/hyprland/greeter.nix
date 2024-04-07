{ pkgs, user, ... }:

let
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  session = "${pkgs.hyprland}/bin/Hyprland";
in

{
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        inherit user;
        command = "${session}";
      };
      default_session = {
        command = "${tuigreet} --greeting 'Ave ave cum ave!' --asterisks --remember --remember-user-session --time --cmd ${session}";
        user = "greeter";
      };
    };
  };
}
