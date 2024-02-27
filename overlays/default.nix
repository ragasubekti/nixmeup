{ pkgs, inputs, ... }: {
  nixpkgs.overlays = [
    inputs.nur.overlay

    (final: prev: {
      wallpaper-engine-kde =
        pkgs.plasma5Packages.callPackage ./wallpaper-engine-kde.nix {
          inherit (pkgs.gst_all_1) gst-libav;
          inherit (pkgs.python3Packages) websockets;
        };
    })
    (final: prev: { adw-gtk3 = prev.callPackage ./adw-gtk.nix { }; })

    (final: prev: {
      gnome = prev.gnome.overrideScope' (gnomeFinal: gnomePrev: {
        mutter = gnomePrev.mutter.overrideAttrs (old: {
          src = pkgs.fetchgit {
            url = "https://gitlab.gnome.org/vanvugt/mutter.git";
            # GNOME 45: triple-buffering-v4-45
            rev = "0b896518b2028d9c4d6ea44806d093fd33793689";
            sha256 = "sha256-mzNy5GPlB2qkI2KEAErJQzO//uo8yO0kPQUwvGDwR4w=";
          };
        });
      });
    })

    # (final: prev: { vimPlugins.surround = prev.vimPlugins.surround; })
  ];
}
