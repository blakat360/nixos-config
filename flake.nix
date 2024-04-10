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
      user = "sigkill";
      email = "blakat360@gmail.com";
      pkgs = nixpkgs.legacyPackages."x86_64-linux";

    in
    {
      homeConfigurations."${user}" = home-manager.lib.homeManagerConfiguration
        {
          inherit pkgs;
          modules = [ ./home ];
          extraSpecialArgs = { inherit user email stylix; };
        };

      nixosConfigurations =
        let
          configs =
            {
              "thinkpad" =
                [
                  nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen3
                  ./hardware/thinkpad.nix
                ];
              "pc" =
                let
                  hardware = with nixos-hardware.nixosModules.common; [
                    gpu.nvidia
                    cpu.amd
                    pc
                    pc.ssd
                  ];
                in
                [
                  # todo: disko
                ] ++ hardware;
            };

          mksystem = systemName: extraModules:
            {
              "${systemName}" = nixpkgs.lib.nixosSystem {
                specialArgs = { };
                system = "x86_64-linux";
                modules = [
                  ({ config, ... }: { networking.hostName = systemName; })
                  ./system/configuration.nix
                  home-manager.nixosModules.home-manager
                  stylix.nixosModules.stylix
                  {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.sigkill = import ./home;
                    home-manager.extraSpecialArgs = {
                      inherit user email stylix;
                    };
                  }
                ] ++ extraModules;
              };
            };
        in
        builtins.mapAttrs mksystem configs;
    };
}

