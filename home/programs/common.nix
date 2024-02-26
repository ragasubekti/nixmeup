{
  pkgs, ...
}: {
  home.packages = with pkgs; [
    fastfetch

    xdg-utils
    clifm
    fd

    zip
    unzip
    unar
    p7zip

    nodejs
    nodePackages.npm
    nodePackages.pnpm
    yarn

    dbeaver
    mycli
    pgcli

    keepassxc
    qbittorrent

    imagemagick
    scrcpy
    pipx

    stdenvNoCC
    gcc

    dotnet-sdk_8

    gnumake
    cmake

    android-studio
    flutter

    rustup

    adw-gtk3

    du-dust
    tealdeer

    wl-clipboard
    xclip

    gnome.gnome-boxes
    virt-manager

    sqlitebrowser
    duperemove
    rmlint
    trash-cli

    distrobox

    onlyoffice-bin
    calibre-web

    cached-nix-shell
    deja-dup
    pika-backup
  ];

  programs = {
    bat.enable = true;
    btop.enable = true;
    eza.enable = true;
    jq.enable = true;
    ssh.enable = true;
    aria2.enable = true;
    gpg.enable = true;

    zellij = {
      enable = true;
      enableFishIntegration = true;
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
      defaultCommand = "fd --type f";
    };

    foot = {
      enable = true;
      settings = {
        main = {
          term = "xterm-256color";
          font = "CaskaydiaCove Nerd Font Mono:size=12";
        };
      };
    };

    direnv = {
      enable = true; 
      nix-direnv.enable = true;
    };
  };
}
