{ pkgs, ... }: {
  dotnet8 = pkgs.mkShell {
    packages = with pkgs; [
      dotnet-sdk_8
      dotnet-runtime_8
      SDL2
      ffmpeg-full
      nushell
    ];

    shellHook = ''
      exec nu
    '';
  };
}
