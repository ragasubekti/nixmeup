{
  config, pkgs, inputs, ...
}: 
let 
  games-opts = {
    filesystems = [
      "home/.games:rw"
    ];
  };
in {
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

    "com.valvesoftware.Steam".Context = games-opts;
    "moe.launcher.an-anime-game-launcher".Context = games-opts;
    "moe.launcher.the-honkers-railway-launcher".Context = games-opts;
  };

  home.packages = let nix-gaming = inputs.nix-gaming.packages.${pkgs.hostPlatform.system}; in [
    
    nix-gaming.osu-lazer-bin
    nix-gaming.osu-stable.override rec {
      wine = nix-gaming.wine-tkg;
      wine-discord-ipc-bridge = nix-gaming.wine-discord-ipc-bridge.override {inherit wine;};
      location = "${config.home.homeDirectory}/games/osu-nix";
    }

    pkgs.yuzu
    pkgs.rpcs3
    pkgs.ppsspp
    pkgs.retroarch
    pkgs.protontricks
  ];
}
