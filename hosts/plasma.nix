{ pkgs, ... }:

{
  services.xserver = {
    enable = true;

    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
    
    layout = "us";
    xkbVariant = "";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk  pkgs.xdg-desktop-portal-kde ];
  };

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    
    input-remapper
    
    libsForQt5.qt5.qtwebsockets

    (pkgs.python3.withPackages (python-pkgs: [
      python-pkgs.websockets
    ]))

    wallpaper-engine-kde
  ];
}
