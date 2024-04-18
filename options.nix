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
    isNvidia = mkOption {
      type = bool;
      description = mdDoc "Whether the system has an nvidia gpu";
    };
    hasBattery = mkOption {
      type = bool;
      description = mdDoc "Whether the system has a battery";
    };
    email = mkOption {
      type = nullOr str;
      description = mdDoc "The email associated with the main user";
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
