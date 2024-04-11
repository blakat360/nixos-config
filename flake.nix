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
          inherit (pkgs) lib;
          configs =
            {
              "thinkpad" =
                {
                  extraModules =
                    [
                      nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen3
                      ./hardware/thinkpad.nix
                    ];
                };
              "pc" = {
                disk = "nvme1n1";
                extraModules =
                  with nixos-hardware.nixosModules;
                  [
                    common-gpu-nvidia
                    common-cpu-amd
                    common-pc
                    common-pc-ssd
                  ];
              };
            };


          mksystem = systemName: spec:
            nixpkgs.lib.nixosSystem {
              specialArgs = { };
              system = "x86_64-linux";
              modules = [
                ({ config, ... }: { networking.hostName = systemName; }
                  // lib.attrsets.optionalAttrs (spec ? disk) (import ./system/diskoTemplate.nix spec.disk))
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
              ] ++ spec.extraModules;
            };
        in
        builtins.mapAttrs mksystem configs;
    };
}

