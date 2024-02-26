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
  ];
}
