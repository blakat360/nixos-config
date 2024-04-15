{ config, pkgs, ... }:
{
  imports =
    [
      ./wm/hyprland
      ./virtualisation.nix
      ./styling
    ];

  nix = {
    package = pkgs.nixFlakes;
    settings = {
      trusted-substituters = [
        "https://nix-community.cachix.org"
        "https://hydra.nixos.org"
      ];
      trusted-users = [
        "@wheel"
      ];
    };
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking = {
    wireless.enable = false; # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;
    nameservers = [ "1.1.1.1" "8.8.8.8" ];
  };


  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.utf8";

  # Configure keymap in X11
  services = {
    printing.enable = true;
    udisks2.enable = true;
    fstrim.enable = true;
  };
  virtualisation.docker.enable = true;

  # keymap in tty
  console.keyMap = "us";

  # Enable sound with pipewire.
  sound.enable = true;
  hardware = {
    pulseaudio.enable = false;
    xpadneo.enable = true;
  };
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    "${config.user}" = {
      isNormalUser = true;
      shell = pkgs.fish;
      initialPassword = "a";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      openssh.authorizedKeys.keys = [
        (import ./sshPub.nix)
      ];
    };
    root.openssh.authorizedKeys.keys = [
      (import ./sshPub.nix)
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    comma
    nvfetcher
    grc
  ];

  programs = {
    # running binaries on nix
    nix-ld.enable = true;
    steam.enable = true;
    fish.enable = true;
  };

  programs.nix-ld.libraries = with pkgs; [
    alsa-lib
    atk
    at-spi2-atk
    at-spi2-core
    cairo
    cups
    curl
    dbus
    expat
    fontconfig
    freetype
    fuse3
    gdk-pixbuf
    glib
    gtk3
    icu
    libappindicator-gtk3
    libdrm
    libGL
    libglvnd
    libnotify
    libpulseaudio
    libunwind
    libusb1
    libuuid
    libxkbcommon
    libxml2
    mesa
    nspr
    nss
    openssl
    pango
    pipewire
    stdenv.cc.cc
    stdenv.cc.cc.lib
    systemd
    vulkan-loader
    xorg.libX11
    xorg.libxcb
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libxkbfile
    xorg.libXrandr
    xorg.libXrender
    xorg.libXScrnSaver
    xorg.libxshmfence
    xorg.libXtst
    zlib
  ];

  hardware.bluetooth.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.16"; # Did you read the comment?

}
