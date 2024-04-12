{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    stylix.url = "github:danth/stylix";
  };

  outputs =
    { nixpkgs, home-manager, nixos-hardware, stylix, ... }:
    let
      systemConfigs = import ./systemConfigs.nix;
      options = import ./options.nix;
    in
    {
      nixosConfigurations =
        let
          mkSystem = systemName: configSpec:
            nixpkgs.lib.nixosSystem {
              specialArgs = {
                inherit nixos-hardware stylix;
              };
              system = "x86_64-linux";
              modules = [
                options # defines options
                configSpec # sets options
                ({ config, ... }: {
                  networking.hostName = systemName;
                })
                ./system/configuration.nix
                home-manager.nixosModules.home-manager
                stylix.nixosModules.stylix
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.sigkill =
                    ({ config, ... }: {
                      imports = [
                        configSpec # defines all the options defining what this should be
                        ./home
                      ];
                    });
                  home-manager.extraSpecialArgs = {
                    inherit stylix nixos-hardware;
                  };
                }
              ];
            };
        in
        builtins.mapAttrs mkSystem systemConfigs;
    };
}

