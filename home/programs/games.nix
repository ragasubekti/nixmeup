{
  lib, pkgs, inputs, ...
}: {
  home.packages = [
    inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.osu-lazer-bin
    inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.osu-stable
    pkgs.lutris
    pkgs.bottles
  ];
}