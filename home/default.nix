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
    plugins = [
      pkgs.fishPlugins.z
      pkgs.fishPlugins.fzf-fish
      pkgs.fishPlugins.done
    ];
  };

  systemd.user.startServices = "sd-switch";
}