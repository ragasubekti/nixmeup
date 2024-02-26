{
  pkgs, inputs, ...
}: {
  services.flatpak.enable = true;
  services.flatpak.update.auto.enable = false;
  services.flatpak.uninstallUnmanagedPackages = true;
  
  services.flatpak.remote = [
    {
      name = "flathub";
      location = "https://flathub.org/repo/flathub.flatpakrepo";
    }
    {
      name = "launcher.moe";
      location = "https://gol.launcher.moe/gol.launcher.moe.flatpakrepo";
    }
  ];

  services.flatpak.packages = [
    "com.github.tchx84.Flatseal"
    "com.usebottles.bottles"
    "com.valvesoftware.Steam"
    "io.github.jeffshee.Hidamari"
    "net.davidotek.pupgui2"
    "net.lutris.Lutris"

    { appId = "moe.launcher.an-anime-game-launcher"; origin = "launcher.moe"; }
    { appId = "moe.launcher.the-honkers-railway-launcher"; origin = "launcher.moe"; }
  ];

  service.flatpak.overrides = {
    global = {
      # Force Wayland by default
      Context.sockets = ["wayland" "!x11" "!fallback-x11"];

      Environment = {
        XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";
      };
    };

    "com.valvesoftware.Steam".Context = {
      filesystems = [
        "home/.games:rw"
      ];
    };
  };

  home.packages = [
    
    inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.osu-lazer-bin
    inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.osu-stable

    pkgs.yuzu
    pkgs.rpcs3
    pkgs.ppsspp
    pkgs.retroarch
    pkgs.protontricks
  ];
}
