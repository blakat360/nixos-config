{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs =
    inputs@{ nixpkgs, home-manager, nix-colors, flake-utils, ... }:
    let
      user = "sigkill";
      email = "blakat360@gmail.com";
    in
    rec {
      nixosConfigurations =
        let
          lib = nixpkgs.lib;
          mksystem = system_name:
            {
              "${system_name}" = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit nix-colors; };
                system = "x86_64-linux";
                modules = [
                  ({ config, ... }: { networking.hostName = system_name; })
                  ./system/configuration.nix
                  ./system/laptop.nix
                  ./hardware/thinkpad.nix
                  home-manager.nixosModules.home-manager
                  {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.sigkill = import ./home;
                    home-manager.extraSpecialArgs = { inherit nix-colors user email; };
                  }
                ];
              };
            };
        in
        mksystem "thinkpad";
    } // flake-utils.lib.eachDefaultSystem (system:
    let pkgs = nixpkgs.legacyPackages.${system}; in
    {
      packages = flake-utils.lib.flattenTree
        {
          homeConfigurations."${user}" = home-manager.lib.homeManagerConfiguration
            {
              inherit pkgs;
              modules = [ ./home ];
              extraSpecialArgs = { inherit nix-colors user email; };
            };
        };
    });
}

