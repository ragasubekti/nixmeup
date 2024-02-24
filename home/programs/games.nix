{
  lib, pkgs, inputs, pkgs-unstable, aagl-nix, ...
}: {
  home.packages = [
    inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.osu-lazer-bin
    inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.osu-stable

    pkgs-unstable.lutris
    pkgs-unstable.bottles

    aagl-nix.anime-game-launcher
    aagl-nix.honkers-railway-launcher
  ];
}
