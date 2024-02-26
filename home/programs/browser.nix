{ pkgs, home-user, ...}: 
{
  programs = {
    firefox = {
      enable = true;
      profiles.${home-user} = {
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
