{ config, pkgs, inputs, ... }:
let
  nix-gaming = inputs.nix-gaming.packages.${pkgs.hostPlatform.system};
in {
  home.packages = [
    nix-gaming.osu-lazer-bin
    (nix-gaming.osu-stable.override {
      location = "${config.home.homeDirectory}/games/osu-nix";
      wine = nix-gaming.wine-tkg;
    })

    pkgs.yuzuPackages.mainline
    pkgs.rpcs3
    pkgs.ppsspp
    pkgs.retroarch
    pkgs.protontricks
    pkgs.bottles
  ];
}
