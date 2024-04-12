{
  thinkpad = { config, nixos-hardware, ... }: {
    imports = [
      nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen3
      ./hardware/thinkpad.nix
    ];
    config = {
      user = "sikill";
      email = "blakat360@gmail.com";
      isNvidia = false;
    };
  };

  pc = { config, nixos-hardware, ... }: {
    imports =
      with nixos-hardware.nixosModules;
      [
        common-gpu-nvidia
        common-cpu-amd
        common-pc
        common-pc-ssd

        ./system/diskoTemplate.nix
      ];
    config = {
      user = "sikill";
      email = "blakat360@gmail.com";
      isNvidia = true;
    };
    services.disko.disk = "idk rn lol";
  };
}
