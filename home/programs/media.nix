{ lib, pkgs, ... }: {
  home.packages = with pkgs; [
    ffmpeg-full
    opusTools
    opustags

    # Disabled no HWA
    # handbrake 
    
    vlc
    celluloid

    gallery-dl
    imgbrd-grabber

    easyeffects
    kid3
    kdenlive
    openshot-qt
    amberol
    libsForQt5.elisa
  ];

  programs = {
    mpv = { 
      enable = true;
      defaultProfiles = ["gpu-hq"];
      config = {
        hwdec = "auto";
        cache-default = 4000000;
      };
    };

    obs-studio = {
      enable = true;
      plugins = [
        pkgs.obs-studio-plugins.obs-vkcapture
        pkgs.obs-studio-plugins.obs-vaapi
      ];
    };

    yt-dlp = {
      enable = true;
      settings = {
        embed-metadata = true;
        embed-chapters = true;
        embed-thumbnail = true;
        
        downloader = "aria2c";
      };
    };
  };
}
