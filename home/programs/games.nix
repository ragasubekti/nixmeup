{
  lib, pkgs, inputs, pkgs-unstable, ...
}: {
  home.packages = [
    inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.osu-lazer-bin
    inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.osu-stable

    pkgs-unstable.lutris
    pkgs-unstable.bottles
  ];
}
