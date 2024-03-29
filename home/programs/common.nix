{ config, pkgs, inputs, ... }: {
  home.packages = with pkgs; [
    fastfetch

    xdg-utils
    clifm
    fd
    ripgrep

    zip
    unzip
    unar
    p7zip

    # nodejs
    # nodePackages.npm
    # nodePackages.pnpm
    # yarn

    dbeaver
    # pgcli

    keepassxc
    qbittorrent

    imagemagick
    scrcpy
    adb-sync
    # pipx

    # stdenvNoCC
    # gcc

    # dotnet-sdk_8

    # gnumake
    # cmake

    # android-studio
    # flutter

    # rustup

    adw-gtk3

    dust
    tealdeer

    wl-clipboard
    xclip

    gnome.gnome-boxes
    virt-manager

    sqlitebrowser
    duperemove
    rmlint
    # trash-cli
    trashy

    distrobox

    onlyoffice-bin
    calibre-web

    cached-nix-shell
    deja-dup
    pika-backup
    resources

    # inputs.nix-software-center.packages.${system}.nix-software-center
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

      settings = {
        simplified_ui = true;
        theme = "catppuccin-mocha";
        default_layout = "compact";
      };
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

    # borgmatic = {
    #   enable = true;
    #   backups = {
    #     home-dir = {
    #       location.repository = [{
    #         path = "/mnt/hdd/backup/borgmatic/home.borg";
    #         label = "local";
    #       }];
    #       location.source = config.home.homeDirectory;

    #       location.excludeHomeManagerSymlinks = true;

    #     };
    #   };
    # };
  };
}
