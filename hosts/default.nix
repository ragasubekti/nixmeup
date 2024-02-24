{ config, pkgs, inputs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./storage.nix
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

  services.printing.enable = false;
  services.flatpak.enable = true;

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
      intel-media-driver
      vaapiIntel
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

  programs.gamemode.enable = true;

  programs.adb.enable = true;

  system.stateVersion = "23.11";
}
