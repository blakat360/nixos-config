{ lib, ... }:
let
  inherit (lib) mkOption mdDoc;
  inherit (lib.types) nullOr bool str;
in
{
  options = {
    user = mkOption {
      type = str;
      description = mdDoc "The main user (not root)";
    };
    email = mkOption
      {
        type = nullOr str;
        description = mdDoc "The email associated with the main user";
      };
    isNvidia = mkOption {
      type = bool;
      description = mdDoc ''
        Mark the system as one with an nvidia gpu.

        NB: This is not used to pull in nixos-hardware modules, only to configure various installed services and programs
      '';
    };
    services.disko.disk = mkOption {
      type = nullOr str;
      description = mdDoc ''
        The /dev/<disk> to partition e.g. "nvme0n1" or "sda". 

        NB: You need to import the appropriate template manually
      '';
    };
  };
}
