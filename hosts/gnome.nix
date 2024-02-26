{ pkgs, inputs, ... }:

{
  services.xserver = {
    enable = true;

    displayManager.gdm.enable = true;

    desktopManager.gnome.enable = true;
    displayManager.defaultSession = "gnome";

    layout = "us";
    xkbVariant = "";
  };

  xdg.portal.enable = true;

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl

    gnome.gnome-tweaks
    adw-gtk3

    input-remapper
    wl-clipboard
  ];
}
