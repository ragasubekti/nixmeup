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
  nixpkgs.config.allowAliases = false;

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl

    gnome.gnome-tweaks
    adw-gtk3

    input-remapper
    wl-clipboard
    lutris

    gnome.adwaita-icon-theme
    gnomeExtensions.appindicator
    gnome.gnome-settings-daemon

    # use overlay
    gnome.mutter
  ];

  systemd.extraConfig = ''
    DefaultLimitNOFILE=1048576
  '';

  systemd.user.extraConfig = ''
    DefaultLimitNOFILE=1048576
  '';
}
