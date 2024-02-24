{
  description = "Yeet The Child";

  nixConfig = {
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"

      "https://nix-gaming.cachix.org"
      "https://ezkea.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";
    nix-gaming.url = "github:fufexan/nix-gaming";

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nur, aagl, nixpkgs-unstable, ... }@inputs:
    let
      system = "x86_64-linux";

      pkgs-unstable = import nixpkgs-unstable { inherit system; config = { allowUnfree = true; }; };
      pkgs = import nixpkgs { inherit system; config = { allowUnfree = true; }; };
      aagl-nix = aagl.packages.${system};
    in
    {
      nixosConfigurations.starward = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = { inherit inputs pkgs-unstable; };

        modules = [
          ./hosts

          {
            nixpkgs.overlays = [ 
              nur.overlay
              (final: prev: { adw-gtk3 = prev.callPackage ./overlays/adw-gtk.nix {}; })
              (final: prev: { wallpaper-engine-kde = pkgs.plasma5Packages.callPackage ./overlays/wallpaper-engine-kde.nix {
                inherit (pkgs.gst_all_1) gst-libav;
                inherit (pkgs.python3Packages) websockets;
              }; })
            ];

            imports = [ aagl.nixosModules.default ];
            nix.settings = aagl.nixConfig;
          }

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.extraSpecialArgs = { inherit inputs pkgs-unstable aagl-nix; };
            home-manager.users.guinaifen = import ./home;
          }
        ];

      };

      devShells.${system}.dotnet8 = let
        pkgs = import nixpkgs {
            inherit system;
        };
        in pkgs.mkShell {
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
    };
}
