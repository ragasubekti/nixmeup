{ pkgs, ... }: 
{
  nixpkgs.overlays = with pkgs; [
    nur.overlay
    
    (final: prev: {
      wallpaper-engine-kde = plasma5Packages.callPackage ./wallpaper-engine-kde.nix {
        inherit (gst_all_1) gst-libav; 
        inherit (python3Packages) websockets; 
      };
    })
    (final: prev: { adw-gtk3 = prev.callPackage ./adw-gtk.nix {}; })
  ];
}