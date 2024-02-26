{ pkgs, ... }: {
  dotnet8 = pkgs.mkShell {
    packages = with pkgs; [
      stdenvNoCC
      SDL2
      ffmpeg_4
      icu
      libkrb5
      lttng-ust
      numactl
      openssl
      vulkan-loader
      dotnet-sdk_8

      nushell
    ];

    shellHook = ''
      exec nu
    '';
  };

  android = pkgs.mkShell { packages = with pkgs; [ android-studio flutter ]; };
}
