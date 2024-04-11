{ config, lib, ... }:
let
  inherit (lib) mkOption mkEnableOption mdDoc;
  inherit (lib.types) nullor listof bool str raw;
in
{
  options = {
    user = mkOption {
      type = str;
      description = mdDoc "The main user (not root)";
    };
    email = mkOption
      {
        type = nullor str;
        description = mdDoc "The email associated with the main user";
      };
    isNvidia = mkOption {
      type = bool;
      description = mdDoc ''
        Mark the system as one with an nvidia gpu.

        NB: This is not used to pull in nixos-hardware modules, only to configure various installed services and programs
      '';
    };
    system.extraModules = mkOption
      {
        type = listof raw;
        description = mdDoc ''
          Extra nix modules specific to this machine

          e.g. nixos-hardware modules
        '';
        default = [ ];
      };
    extraHomeModules = mkOption
      {
        type = listof raw;
        description = mdDoc ''
          Extra home-manager modules specific to this machine
        '';
        default = [ ];
      };
    services.disko = {
      enable = mkEnableOption
        {
          description = mdDoc "Whether to format the disk using disko";
          default = false;
        };
      disk = mkOption {
        type = nullor str;
        description = mdDoc ''
          The /dev/<disk> to partition

          e.g. "nvme0n1" or "sda";
        '';
      };
      config = mkOption {
        type = nullor raw;
        description = mdDoc "The disko configuration to use";
      };
    };
  };
}
