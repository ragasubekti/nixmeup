{ config, pkgs, inputs, ... }:
let
  games-opts = { filesystems = [ "~/games:rw" ]; };

  nix-gaming = inputs.nix-gaming.packages.${pkgs.hostPlatform.system};
in {
  services.flatpak.enable = true;
  services.flatpak.update.auto.enable = false;

  # Still need to manually specify version of Gamescope and Mangohud
  services.flatpak.uninstallUnmanagedPackages = false;

  services.flatpak.remotes = [
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

    "runtime/org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/23.08"

    {
      appId = "moe.launcher.an-anime-game-launcher";
      origin = "launcher.moe";
    }
    {
      appId = "moe.launcher.the-honkers-railway-launcher";
      origin = "launcher.moe";
    }
  ];

  services.flatpak.overrides = {
    global = {
      # Force Wayland by default
      Context.sockets = [ "wayland" "!x11" "!fallback-x11" ];

      Environment = {
        XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";
      };
    };

    "com.valvesoftware.Steam".Context = games-opts;
    "moe.launcher.an-anime-game-launcher".Context = games-opts;
    "moe.launcher.the-honkers-railway-launcher".Context = games-opts;
  };

  home.packages = [
    nix-gaming.osu-lazer-bin
    (nix-gaming.osu-stable.override rec {
      wine = nix-gaming.wine-tkg;
      location = "${config.home.homeDirectory}/games/osu-nix";
      wine-discord-ipc-bridge =
        nix-gaming.wine-discord-ipc-bridge.override { inherit wine; };
    })

    pkgs.yuzu
    pkgs.rpcs3
    pkgs.ppsspp
    pkgs.retroarch
    pkgs.protontricks
  ];
}
