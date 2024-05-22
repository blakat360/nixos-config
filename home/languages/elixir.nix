{ pkgs, ... }:
{
  home.packages = with pkgs; [
    elixir
    postgresql
    inotify-tools
  ];
}

