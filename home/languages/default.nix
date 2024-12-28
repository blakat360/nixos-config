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
    rabbitmq-c
    flatbuffers
    typescript
    nodePackages.prettier
    pyright
  ];
}
