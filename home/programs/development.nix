{ config, pkgs, ... }: {
  home.packages = with pkgs; [ nil nixfmt shfmt shellcheck ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-nox;
    extraPackages = epkgs: [ epkgs.vterm ];
  };

  xdg.configFile = {
    emacs = {
      source = builtins.fetchGit {
        url = "https://github.com/doomemacs/doomemacs";
        rev = "98d753e1036f76551ccaa61f5c810782cda3b48a";
      };

      onChange = "${pkgs.writeShellScript "doom-change" ''
        export DOOMDIR="${config.home.sessionVariables.DOOMDIR}"
        export DOOMLOCALDIR="${config.home.sessionVariables.DOOMLOCALDIR}"

        if [ ! -d "$DOOMLOCALDIR" ]; then
          ${config.xdg.configHome}/emacs/bin/doom -y install
        else
          ${config.xdg.configHome}/emacs/bin/doom -y sync -u
        fi
      ''}";
    };

    doom-config = {
      source = ../../dotfiles/doom;
      recursive = true;
    };
  };
}
