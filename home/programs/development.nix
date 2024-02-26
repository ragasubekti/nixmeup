{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [ nil nixfmt shfmt shellcheck ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-nox;
    extraPackages = epkgs: [ epkgs.vterm ];
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
