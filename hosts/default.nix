{ config, pkgs, inputs, pkgs-unstable, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./virtualization.nix
      inputs.nix-gaming.nixosModules.pipewireLowLatency
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_xanmod;

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

  services.xserver = {
    enable = true;
    
    # GNOME
    # displayManager.gdm.enable = true;
    
    # desktopManager.gnome.enable = true;
    # displayManager.defaultSession = "gnome";

    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
    
    layout = "us";
    xkbVariant = "";
  };

  services.printing.enable = false;
  services.flatpak.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk  pkgs.xdg-desktop-portal-kde ];
  };


  fonts.fontDir.enable = true;
  
  services.ratbagd.enable = true;

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

  # services.zram-generator.enable = true;
  # services.zram-generator.settings = {
  #
  #   };

  users.users.guinaifen = {
    isNormalUser = true;
    description = "Guinaifen";
    extraGroups = [ "networkmanager" "wheel" "adbusers" "libvirtd" ];
    shell = pkgs.fish;
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = [ "guinaifen" ];

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl

    # gnome.gnome-tweaks
    
    pkgs-unstable.input-remapper
    pkgs-unstable.pipewire
    
    libsForQt5.qt5.qtwebsockets


    (pkgs.python3.withPackages (python-pkgs: [
      python-pkgs.websockets
    ]))

    wallpaper-engine-kde
  ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    merriweather

    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "CascadiaCode" ]; })
  ];

    fontconfig.defaultFonts = {
      serif = [ "Merriweather" ];
      sansSerif = [ "Noto Sans" ];
      monospace = [ "CaskaydiaCove Nerd Font Mono" ];
    };
  };


  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  environment.sessionVariables = { 
    LIBVA_DRIVER_NAME = "iHD";
    NIXOS_OZONE_WL = "1";
  };

  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };
  hardware.bluetooth.enable = true;


  programs.fish.enable = true;
  programs.dconf.enable = true;

  # programs.steam.enable = true;
  programs.gamemode.enable = true;

  programs.adb.enable = true;

  system.stateVersion = "23.11";
}
