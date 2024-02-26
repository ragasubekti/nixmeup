{ pkgs, ... }:

{
  services.xserver = {
    enable = true;

    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
    desktopManager.xterm.enable = false;
    desktopManager.xfce.enable = true;

    layout = "us";
    xkbVariant = "";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-kde ];
  };

  environment.systemPackages = with pkgs; [
    git
    wget
    curl

    input-remapper

    libsForQt5.qt5.qtwebsockets

    (pkgs.python3.withPackages (python-pkgs: [ python-pkgs.websockets ]))

    wallpaper-engine-kde

    # XFCE
    drawing
    elementary-xfce-icon-theme
    evince
    font-manager
    gnome.file-roller
    gnome.gnome-disk-utility
    pavucontrol
    wmctrl
    xclip
    xcolor
    xcolor
    xdo
    xdotool
    xfce.catfish
    xfce.gigolo
    xfce.orage
    xfce.xfburn
    xfce.xfce4-appfinder
    xfce.xfce4-clipman-plugin
    xfce.xfce4-cpugraph-plugin
    xfce.xfce4-dict
    xfce.xfce4-fsguard-plugin
    xfce.xfce4-genmon-plugin
    xfce.xfce4-netload-plugin
    xfce.xfce4-panel
    xfce.xfce4-pulseaudio-plugin
    xfce.xfce4-systemload-plugin
    xfce.xfce4-weather-plugin
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-xkb-plugin
    xfce.xfdashboard
    xorg.xev
    xsel
    xtitle
    xwinmosaic
    zuki-themes
  ];

  programs = {
    # dconf.enable = true;
    # gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-volman
      ];
    };
  };
}
