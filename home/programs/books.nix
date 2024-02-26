{ pkgs, ... }: {
  home.packages = with pkgs; [ calibre koreader mangal foliate ];
}
