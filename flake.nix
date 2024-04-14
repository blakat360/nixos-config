{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    disko.url = "github:nix-community/disko";

    stylix.url = "github:danth/stylix";
  };

  outputs =
    { nixpkgs, home-manager, nixos-hardware, stylix, disko, ... }:
    let
      systemConfigs = import ./systemConfigs.nix;
      options = import ./options.nix;
    in
    {
      nixosConfigurations =
        let
          mkSystem = systemName: spec:
            nixpkgs.lib.nixosSystem {
              specialArgs = {
                inherit nixos-hardware stylix;
              };
              system = "x86_64-linux";
              modules = [
                options # defines options
                spec.systemImports
                spec.config
                disko.nixosModules.disko
                ({ config, ... }: {
                  networking.hostName = systemName;
                })
                ./system/configuration.nix
                home-manager.nixosModules.home-manager
                stylix.nixosModules.stylix
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users = {
                    "${spec.config.user}" = {
                      imports = [
                        ./home
                        ({ config, ... }: {
                          imports = [ options ];
                          inherit (spec) config;
                        })
                      ];
                    };
                  };

                  home-manager.extraSpecialArgs = {
                    inherit stylix nixos-hardware;
                  };
                }
              ];
            };
        in
        (
          builtins.mapAttrs mkSystem systemConfigs
        ) //
        {
          iso = nixpkgs.lib.nixosSystem
            {
              system = "x86_64-linux";
              modules = [
                "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix"
                "${nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
                {
                  nix.extraOptions = "experimental-features = nix-command flakes";

                  users.users.root.openssh.authorizedKeys.keys = [
                    (import ./system/sshPub.nix)
                  ];
                }
              ];
            };
        };
    };
}

