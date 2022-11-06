{ config, pkgs, callPackage, ... }:

let
  mod = "Mod4";
in
{
   environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw
   services.xserver = {
     enable = true;
     autorun = false;
     displayManager.defaultSession = "none+i3";
     desktopManager = {
       default = "none";
       xterm.enable = false;
     };
     windowManager.i3 = {
       enable = true;
       extraPackages = with pkgs; [
         dmenu #application launcher most people use
         i3status # gives you the default i3 status bar
         i3lock #default i3 screen locker
         i3blocks #if you are planning on using i3blocks over i3status
       ];
     };
     config = {
       "${mod}+Return" = "exec st";
     };
   };
}
