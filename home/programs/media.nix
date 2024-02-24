{ lib, pkgs, ... }: {
  home.packages = with pkgs; [
    ffmpeg-full
    opusTools
    opustags

    # Disabled no HWA
    # handbrake 
    
    vlc
    celluloid

    yt-dlp
    gallery-dl
    imgbrd-grabber

    easyeffects
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
