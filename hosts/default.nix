{ config, pkgs, inputs, home-user, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./storage.nix
    ./virtualization.nix
    inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_cachyos;

  boot.kernelParams = [ "i915.enable_guc=2" ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Tokyo";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ja_JP.UTF-8";
    LC_IDENTIFICATION = "ja_JP.UTF-8";
    LC_MEASUREMENT = "ja_JP.UTF-8";
    LC_MONETARY = "ja_JP.UTF-8";
    LC_NAME = "ja_JP.UTF-8";
    LC_NUMERIC = "ja_JP.UTF-8";
    LC_PAPER = "ja_JP.UTF-8";
    LC_TELEPHONE = "ja_JP.UTF-8";
    LC_TIME = "ja_JP.UTF-8";
  };

  services = {
    printing.enable = false;

    ratbagd.enable = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    lowLatency = {
      enable = true;
      quantum = 64;
      rate = 48000;
    };
  };

  zramSwap.enable = true;

  users.groups = { media_user.gid = 569; };

  users.users.${home-user} = {
    isNormalUser = true;
    description = "Guinaifen";
    extraGroups =
      [ "networkmanager" "wheel" "adbusers" "libvirtd" "media_user" ];
    shell = pkgs.fish;
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;

    #packageOverrides = pkgs: {
    #  vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
    #};
  };

  nix = {
    optimise.automatic = true;

    settings = {
      auto-optimise-store = true;

      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "guinaifen" ];
    };
  };

  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;

    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif

      noto-fonts-emoji-blob-bin
      liberation_ttf
      merriweather

      (nerdfonts.override {
        fonts = [ "FiraCode" "DroidSansMono" "CascadiaCode" ];
      })
    ];

    fontconfig.defaultFonts = {
      serif = [ "Merriweather" ];
      sansSerif = [ "Noto Sans" ];
      monospace = [ "CaskaydiaCove Nerd Font Mono" ];
    };
  };

  # Fix Flatpak cannot access System Fonts
  system.fsPackages = [ pkgs.bindfs ];
  fileSystems = let
    mkRoSymBind = path: {
      device = path;
      fsType = "fuse.bindfs";
      options = [ "ro" "resolve-symlinks" "x-gvfs-hide" ];
    };

    aggregatedIcons = pkgs.buildEnv {
      name = "system-icons";
      paths = with pkgs; [ gnome.gnome-themes-extra ];
      pathsToLink = [ "/share/icons" ];
    };

    aggregatedFonts = pkgs.buildEnv {
      name = "system-fonts";
      paths = config.fonts.packages;
      pathsToLink = [ "/share/fonts" ];
    };

  in {
    "/usr/share/icons" = mkRoSymBind "${aggregatedIcons}/share/icons";
    "/usr/local/share/fonts" = mkRoSymBind "${aggregatedFonts}/share/fonts";
  };

  hardware = {
    bluetooth.enable = true;

    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vaapi-intel-hybrid
        vaapiVdpau
        libvdpau-va-gl
      ];

      driSupport32Bit = true;
    };

    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    NIXOS_OZONE_WL = "1";
  };

  programs = {
    fish.enable = true;
    dconf.enable = true;

    gamemode.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall =
        true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall =
        true; # Open ports in the firewall for Source Dedicated Server
    };

    adb.enable = true;
  };

  system.stateVersion = "23.11";
}
