{ pkgs, ... }: {
  imports = [
    ./go.nix
    ./erlang.nix
    ./cpp.nix
    ./rust.nix
    ./web-dev.nix
  ];

  home.packages = with pkgs; [ nodePackages.prettier ];
}
