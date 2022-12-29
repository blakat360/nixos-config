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
      nixosConfigurations =
        let
          systems = [ "thinkpad" "legion" ];
          mksystem = system_name:
            {
              "${system_name}" = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit nix-colors; };
                system = "x86_64-linux";
                modules = [
                  ({ config, ... }: { networking.hostName = system_name; })
                  (./hardware + "/${system_name}.nix")
                  ./system/configuration.nix
                  ./system/laptop.nix
                  home-manager.nixosModules.home-manager
                  {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.sigkill = import ./home;
                    home-manager.extraSpecialArgs = { inherit nix-colors; };
                  }
                ];
              };
            };
        in
        nixpkgs.lib.foldl nixpkgs.lib.mergeAttrs {} (map mksystem systems);
    };
}
