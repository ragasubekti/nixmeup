{
  lib, pkgs, inputs, ...
}: {
  home.packages = [
    # Use Flatpak Instead
    
    inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.osu-lazer-bin
    # inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.osu-stable

    
    # lutris
    # bottles
    pkgs.yuzu
    pkgs.rpcs3
    pkgs.ppsspp
    pkgs.retroarch
    pkgs.protontricks
  ];
}
