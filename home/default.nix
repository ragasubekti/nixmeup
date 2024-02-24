{ config, pkgs, inputs, ... }:

{
  imports = [
    ./programs
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
