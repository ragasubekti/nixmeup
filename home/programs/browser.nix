{
  pkgs,
  config,
  inputs,
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
}