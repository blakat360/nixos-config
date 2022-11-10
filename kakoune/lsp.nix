{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    rust-analyzer
    python310Packages.python-lsp-server
  ];

  # turn this into an overlay you can apply to pkgs

  programs.kakoune = {
    plugins = [ kak-lsp ];
    extraConfig = '' # recommended mappings
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
  
  xdg.configFile = {
    "kak-lsp/kak-lsp.toml".text = ''
      [language.rust]
      filetypes = ["rust"]
      roots = ["Cargo.toml"]
      command = "rust-analyzer"

      [language.python]
      filetypes = ["python"]
      roots = ["requirements.txt", "setup.py", ".git", ".hg"]
      command = "pylsp"
      offset_encoding = "utf-8"
    '';
    "kak/autoload/lsp_".text =   };
}
