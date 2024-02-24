{
  lib, pkgs, pkgs-unstable, ...
}: {
  home.packages = with pkgs; [
    pkgs-unstable.ffmpeg-full
    opusTools
    opustags
    pkgs-unstable.handbrake
    vlc
    celluloid

    pkgs-unstable.yt-dlp
    pkgs-unstable.gallery-dl
    pkgs-unstable.imgbrd-grabber

    pkgs-unstable.easyeffects
  ];

  programs = {
    mpv = { 
      enable = true;
      defaultProfiles = ["gpu-hq"];
    };

    obs-studio = {
      enable = true;
      plugins = [
        pkgs.obs-studio-plugins.obs-vkcapture
        pkgs.obs-studio-plugins.obs-vaapi
      ];
    };
  };
}
