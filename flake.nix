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
    inputs@{ nixpkgs, home-manager, nix-colors, ... }: rec {
      nixosConfigurations =
        let
          systems = [ "thinkpad" "legion-nvidia" "iso" ];
          lib = nixpkgs.lib;
          extra_modules = system_name:
            let
              tags = lib.filter lib.isString (lib.strings.split "-" system_name);
            in
            map (tag: ./hardware + "/${tag}.nix") tags;
          mksystem = system_name:
            {
              "${system_name}" = lib.nixosSystem {
                specialArgs = { inherit nix-colors; };
                system = "x86_64-linux";
                modules = [
                  ({ config, ... }: { networking.hostName = system_name; })
                  ./system/configuration.nix
                  ./system/laptop.nix
                  home-manager.nixosModules.home-manager
                  {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.sigkill = import ./home;
                    home-manager.extraSpecialArgs = { inherit nix-colors; };
                  }
                ] ++ (extra_modules system_name);
              };
            };
        in
        lib.foldl lib.mergeAttrs { } (map mksystem systems);
        packages."x86_64-linux".default = nixosConfigurations.iso.config.system.build.isoImage;
    };
}
