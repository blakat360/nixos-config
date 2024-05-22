{ pkgs, ... }: {
  imports = [
    ./cpp.nix
    ./elixir.nix
    ./erlang.nix
    ./go.nix
    ./rust.nix
    ./web-dev.nix
  ];

  home.packages = with pkgs; [ nodePackages.prettier ];
}
