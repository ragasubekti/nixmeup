{ config, pkgs, inputs, ... }:

{
  imports = [
    ./programs
    ./fonts
  ];

  nixpkgs = { 
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "guinaifen";
    homeDirectory = "/home/guinaifen";

    stateVersion = "23.11";
  };

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;

  programs.fish = {
    enable = true;
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
    "$HOME/Android/Sdk/platform-tools"
  ];

  systemd.user.startServices = "sd-switch";
}