{ pkgs, ... }:
let galleryDlPath = "/mnt/hdd/data/gallery-dl";
in {
  home.packages = with pkgs; [
    ffmpeg-full
    opusTools
    opustags

    # Disabled no HWA
    # handbrake

    vlc
    celluloid

    imgbrd-grabber

    easyeffects
    kid3
    libsForQt5.kdenlive
    openshot-qt
    amberol
    libsForQt5.elisa
    soundconverter
  ];

  programs = {
    mpv = {
      enable = true;
      defaultProfiles = [ "gpu-hq" ];
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

        download-archive = "/mnt/hdd/media/youtube_download.txt";
        downloader = "aria2c";
      };
    };
  };

  programs.gallery-dl = {
    enable = true;
    settings.extractor = {
      base-directory = galleryDlPath;
      archive = "${galleryDlPath}/archive.sqlite3";
      archive-pragma = [ "journal_mode=WAL" "synchronous=NORMAL" ];

      postprocessors = [{
        name = "metadata";
        mode = "tags";
        whitelist = [ "danbooru" "moebooru" "sankaku" ];
      }];

      kemonoparty.postprocessors = [{
        name = "metadata";
        event = "post";
        filename = "{id} {title}.txt";
        mode = "custom";
        format = ''
          {content}
          {embed[url]:?/
          /}'';

        filter =
          "embed.get('url') or re.search(r'(?i)(gigafile|xgf|1drv|mediafire|mega|google|drive)', content)";
      }];

      mangadex = {
        lang = "en";
        postprocessors = [ "cbz" ];
      };

    };

    settings.downloader = {
      retries = 3;
      timeout = 10;
      part-directory = "${galleryDlPath}/.tmp";
      mtime = false;
    };

    settings.cache.file = "${galleryDlPath}/cache.sqlite3";
  };

}
