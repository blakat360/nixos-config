{... }:

{
  imports = [
    ./lsp.nix
    ./theme.nix
  ];

  home.sessionsVariables = {
    EDITO= "hx";
  }

  programs.kakoune = {
    enable = true;
    config = {
      showMatching = true;
      tabStop = 2;
      indentWidth = 2;
      ui.assistant = "cat";
      numberLines.enable = true;
    };
    extraConfig = ''
      map global normal "/" "/(?i)"

      map global goto <left> h
      map global goto <down> j
      map global goto <up> k
      map global goto <right> l
    '';
  };
}