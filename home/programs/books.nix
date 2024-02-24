{
  lib, pkgs, ...
}: {
  home.packages = with pkgs; [
    calibre
    foliate
    koreader
    mangal
    evince
  ];
}