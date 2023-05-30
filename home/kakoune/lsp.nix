{ config, pkgs, ... }:

let
  cpp_pkgs = with pkgs; [
    bear
    clang
    clang-tools
    cling
    cmake
    cmake-language-server
    ninja
  ] ++ (if stdenv.isLinux then [ gdb valgrind ] else [ ]);
in
{
  home.packages = with pkgs; [
    marksman
    taplo
  ] ++ cpp_pkgs;

  programs.kakoune = {
    plugins = with pkgs.kakounePlugins; [ kak-lsp ];
    extraConfig = ''
      # enable kak-lsp for following filetypes
      eval %sh{kak-lsp --kakoune -s $kak_session}
      hook global WinSetOption filetype=(rust|python|go|javascript|typescript|c|cpp|nix) %{
            lsp-enable-window
      }

      # recommended lsp mappings
      map global user l %{:enter-user-mode lsp<ret>} -docstring "LSP mode"
      map global insert <tab> '<a-;>:try lsp-snippets-select-next-placeholders catch %{ execute-keys -with-hooks <lt>tab> }<ret>' -docstring 'Select next snippet placeholder'
      map global object a '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
      map global object <a-a> '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
      map global object e '<a-semicolon>lsp-object Function Method<ret>' -docstring 'LSP function or method'
      map global object k '<a-semicolon>lsp-object Class Interface Struct<ret>' -docstring 'LSP class interface or struct'
      map global object d '<a-semicolon>lsp-diagnostic-object --include-warnings<ret>' -docstring 'LSP errors and warnings'
      map global object D '<a-semicolon>lsp-diagnostic-object<ret>' -docstring 'LSP errors'
    '';
  };

  xdg.configFile."kak-lsp/kak-lsp.toml".source = ./kak-lsp.toml;
}
