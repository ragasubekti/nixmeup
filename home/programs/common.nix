{
  lib, pkgs, pkgs-unstable, ...
}: {
  home.packages = with pkgs; [
    kitty

    xdg-utils
    fzf
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
    neovim

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

    pkgs-unstable.gnome.gnome-boxes
    pkgs-unstable.virt-manager

    sqlitebrowser
    duperemove
    rmlint
    trash-cli

    distrobox
  ];

  programs = {
    bat.enable = true;
    btop.enable = true;
    eza.enable = true;
    jq.enable = true;
    ssh.enable = true;
    aria2.enable = true;
  };

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
