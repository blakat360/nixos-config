{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs =
    inputs@{ nixpkgs, home-manager, nix-colors, ... }: {
      nixosConfigurations = {
        thinkpad = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit nix-colors; };
          system = "x86_64-linux";
          modules = [
            ./system/configuration.nix
            ./hardware/thinkpad.nix
            ./system/laptop.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.sigkill = import ./home;
              home-manager.extraSpecialArgs = { inherit nix-colors; };
            }
          ];
          # networking.hostname = "thinkpad";
        };
      };
    };
}
