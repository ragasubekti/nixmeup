{
  pkgs,
  config,
  inputs,
  pkgs-unstable,
  ...
}: {
  programs = {
    chromium = {
      enable = true;
      commandLineArgs = ["--enable-features=TouchpadOverscrollHistoryNavigation"];
      extensions = [
        
      ];
    };

    firefox = {
      enable = true;
      profiles.guinaifen = {
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          sponsorblock
          tampermonkey
        ];
      };
    };

  };

  home.packages = [
    pkgs.discord
    pkgs.telegram-desktop
    pkgs.thunderbird

    (pkgs.vivaldi.override {
      proprietaryCodecs = true;
      enableWidevine = true;
    })
  ];
}