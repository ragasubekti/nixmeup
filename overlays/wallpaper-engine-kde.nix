{ mkDerivation, fetchurl, cmake, extra-cmake-modules, plasma-framework
, gst-libav, mpv, websockets, qtwebsockets, qtwebchannel, qtdeclarative
, qtx11extras, vulkan-headers, vulkan-loader, vulkan-tools, pkg-config, lz4 }:

mkDerivation rec {
  name = "wallpaper-engine-kde-plugin";
  version = "v0.5.5-nixos";
  cmakeFlags = [ "-DUSE_PLASMAPKG=OFF" ];
  nativeBuildInputs = [ cmake extra-cmake-modules pkg-config ];
  buildInputs = [
    plasma-framework
    mpv
    qtwebsockets
    websockets
    qtwebchannel
    qtdeclarative
    qtx11extras
    lz4
    vulkan-headers
    vulkan-tools
    vulkan-loader
  ];

  patches = [ ./fbda175.patch ];

  # SOURCE: https://discourse.nixos.org/t/need-help-with-wallpaper-engine-kde-plugin-on-nixos-23-05-553-e7603eba51f-stoat-x86-64/30193

  src = fetchurl {
    url =
      "https://github.com/ragasubekti/nixmeup/releases/download/wallpaper-engine-kde/wallpaper-engine-kde-plugin.tar.gz";
    sha256 = "8mb9ro4OH1VpwmryvZjsld2xt5k5tUMJrf0RY4psCBg=";
  };
}
