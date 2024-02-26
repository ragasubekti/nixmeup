{ config, inputs, home-user, ... }: {
  imports = [
    ./programs
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };
  
  home = {
    username = home-user;
    homeDirectory = "/home/${home-user}";

    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;

  programs.fish = {
    enable = true;
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
    "${config.home.homeDirectory}/.cargo/bin"
    "${config.home.homeDirectory}/Android/Sdk/platform-tools"
  ];

  home.sessionVariables = {
    ANDROID_SDK_ROOT = "${config.home.homeDirectory}/Android/Sdk";
    ANDROID_HOME = "${config.home.homeDirectory}/Android/Sdk";
    DOOMDIR = "${config.xdg.configHome}/doom-config";
    DOOMLOCALDIR = "${config.xdg.configHome}/doom-local";
    LSP_USE_PLISTS = "true";
  };

  systemd.user.startServices = "sd-switch";
}
