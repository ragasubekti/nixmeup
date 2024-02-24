{
  lib, pkgs, ...
}: {
  home.packages = with pkgs; [
    ffmpeg-full
    opusTools
    opustags
    handbrake
    vlc
    celluloid
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