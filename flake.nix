{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    mach-nix.url = "github:DavHau/mach-nix";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    stylix.url = "github:danth/stylix";
  };

  outputs =
    inputs@{ nixpkgs, home-manager, flake-utils, mach-nix, nixos-hardware, stylix, ... }:
    let
      user = "sigkill";
      email = "blakat360@gmail.com";
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
    in
    rec {
      homeConfigurations."${user}" = home-manager.lib.homeManagerConfiguration
        {
          inherit pkgs;
          modules = [ ./home ];
          extraSpecialArgs = { inherit user email mach-nix stylix; };
        };

      nixosConfigurations =
        let
          lib = nixpkgs.lib;
          mksystem = system_name:
            {
              "${system_name}" = nixpkgs.lib.nixosSystem {
                specialArgs = { };
                system = "x86_64-linux";
                modules = [
                  ({ config, ... }: { networking.hostName = system_name; })
                  nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen3
                  ./system/configuration.nix
                  ./system/laptop.nix
                  ./hardware/thinkpad.nix
                  home-manager.nixosModules.home-manager
                  stylix.nixosModules.stylix
                  {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.sigkill = import ./home;
                    home-manager.extraSpecialArgs = {
                      inherit user email mach-nix stylix;
                    };
                  }
                ];
              };
            };
        in
        mksystem "thinkpad";
    };
}

