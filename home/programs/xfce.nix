{ pkgs, ... }:

{
  gtk = {
    enable = true;
    iconTheme = {
      name = "elementary-Xfce";
      package = pkgs.elementary-xfce-icon-theme;
    };
    theme = {
      name = "zukitre";
      package = pkgs.zuki-themes;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=0
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=0
      '';
    };
  };

  programs.gpg.enable = true;

  services.gpg-agent.enable = true;
}
