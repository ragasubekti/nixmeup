{
  lib, pkgs, pkgs-unstable, ...
}: {
  home.packages = [
    pkgs.calibre
    pkgs.koreader
    pkgs.mangal
    pkgs-unstable.foliate
  ];
}
