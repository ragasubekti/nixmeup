{ inputs, home-user, ... }: {
  imports = [
    ./programs
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };
  
  home = {
    username = home-user;
    homeDirectory = "/home/${home-user}";

    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;

  programs.fish = {
    enable = true;
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
    "$HOME/Android/Sdk/platform-tools"
  ];

  home.sessionVariables = {
    ANDROID_SDK_ROOT = "$HOME/Android/Sdk";
    ANDROID_HOME = "$HOME/Android/Sdk";
  };

  systemd.user.startServices = "sd-switch";
}
