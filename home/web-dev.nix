{ pkgs, ... }:
let
  node_pkgs = with pkgs.nodePackages; [
    npm
    svelte-check
    svelte-check
    typescript-language-server
  ];
in
{
  home.packages = with pkgs; [
    nodejs
    tree-sitter-grammars.tree-sitter-svelte
    yarn
  ] ++ node_pkgs;
}

