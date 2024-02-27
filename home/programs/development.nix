{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [
    nil
    nixfmt
    nixpkgs-fmt

    shfmt
    shellcheck
    nur.repos.ataraxiasjel.waydroid-script
    python3
    # stdV
    stdenvNoCC
    gcc13
    gnumake
    cmake
    rustup

    nodejs_21

    nodePackages.pnpm
    yarn

    android-studio
    flutter

    lua
    stylua

    go
    gopls
    zulu
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-nox;
    extraPackages = epkgs: [ epkgs.vterm ];
  };

  programs.neovim = {
    enable = false;
    withNodeJs = true;
    vimAlias = true;
  };

  home.activation.install-doom = lib.hm.dag.entryAfter [ "installPackages" ] ''
    if ! [ -d "${config.xdg.configHome}/emacs" ]; then
       PATH="${pkgs.git}/bin:${pkgs.openssh}/bin:$PATH"
       $DRY_RUN_CMD git clone $VERBOSE_ARG --depth=1 --single-branch "https://github.com/doomemacs/doomemacs.git" "${config.xdg.configHome}/emacs"
    fi
  '';

  xdg.configFile = {
    doom-config = {
      source = ../../dotfiles/doom;
      recursive = true;
    };
  };
}
