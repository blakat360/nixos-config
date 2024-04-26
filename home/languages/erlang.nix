{ pkgs, ... }: {
  home.packages = with pkgs; [
    erlang
    erlfmt
    erlang-ls
    rebar3
  ];
}
