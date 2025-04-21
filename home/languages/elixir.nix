{ pkgs, ... }:
{
  home.packages = with pkgs; [
    elixir
    elixir-ls
    postgresql
    inotify-tools
  ];
}

