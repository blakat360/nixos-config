{
  thinkpad = {
    systemImports = { pkgs, nixos-hardware, ... }: {
      imports = [
        ./system/diskoTemplate.nix
        ./hardware/thinkpad.nix
        nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen3
        {
          environment.sessionVariables = {
            WLR_DRM_DEVICES = "/dev/dri/card1";
          };
        }
      ];
    };
    config = {
      user = "sigkill";
      email = "blakat360@gmail.com";
      isNvidia = false;
      hasBattery = true;
      services.disko.disk = "nvme0n1";
    };
  };

  pc = {
    systemImports = { config, nixos-hardware, ... }: {
      imports =
        with nixos-hardware.nixosModules;
        [
          common-gpu-nvidia
          common-cpu-amd
          common-pc
          common-pc-ssd

          {
            hardware.nvidia = {
              prime.offload.enable = false;
              modesetting.enable = true;
              powerManagement = {
                enable = true;
              };
              package = config.boot.kernelPackages.nvidiaPackages.stable;
            };

            services.openssh.enable = true;

            environment.sessionVariables = {
              WLR_DRM_DEVICES = "/dev/dri/card1";
            };


            boot.kernelModules = [
              "nvidia_drm"
            ];
          }

          ./system/diskoTemplate.nix
        ];
    };
    config = {
      user = "sigkill";
      email = "blakat360@gmail.com";
      isNvidia = true;
      hasBattery = false;
      services.disko.disk = "nvme1n1";
    };
  };
}
