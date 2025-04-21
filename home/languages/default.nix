{ pkgs, ... }: {
  imports = [
    ./cpp.nix
    ./elixir.nix
    ./erlang.nix
    ./go.nix
    ./rust.nix
    # issues w work node setup I need to fix
    # ./web-dev.nix
  ];

  home.packages = with pkgs; [
    idris2
    idris2Packages.idris2Lsp
    chez
    rabbitmq-c
    flatbuffers
    typescript
    nodePackages.prettier
    pyright
  ];
}
