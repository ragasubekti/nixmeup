{
  lib, pkgs-unstable, ...
}: {
  home.packages = with pkgs-unstable; [
    calibre
    koreader
    mangal
    foliate
  ];
}
