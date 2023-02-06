# TODO: outfactor the tmux env check into a shell script that is used here
# 			potentially consider spawning a new window to run tmux from
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ fzf silver-searcher ];

  programs.kakoune.extraConfig = ''
  	# find files using skim

    define-command fzf-files \
    -docstring 'Select files in project using ag + fzf ' %{nop %sh{
      FILE=$(ag -g "" | fzf-tmux)
      if [ -n "$FILE" ]; then
        printf 'eval -client %%{%s} edit %%{%s}\n' "''${kak_client}" "''${FILE}" | kak -p "''${kak_session}"
      fi
    } }

  	# go to open buffer using fzf
  	
    define-command fzf-buffers \
    -docstring 'Select an open buffer using fxf' %{ evaluate-commands %sh{
      BUFFER=$(printf "%s\n" "''${kak_buflist}" | tr " " "\n" | fzf-tmux | tr -d \')
      if [ -n "$BUFFER" ]; then
        printf "%s\n" "buffer ''${BUFFER}"
      fi
    } }

  	# fuzzy finder mappings

  	map global user f :fzf-files<ret> -docstring 'file-picker'
  	map global user b :fzf-buffers<ret> -docstring 'buffer-picker'
  '';
}
