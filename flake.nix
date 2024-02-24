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
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";
    nix-gaming.url = "github:fufexan/nix-gaming";
  };

  outputs = { self, nixpkgs, home-manager, nur, nixpkgs-stable, ... }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs { inherit system; config = { allowUnfree = true; }; };

    in
    {
      home-manager.nixosModules.home-manager = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;

        home-manager.extraSpecialArgs = { inherit inputs; };
        home-manager.users.guinaifen = import ./home;
      };

      nixpkgs.overlays = with pkgs; [
        nur.overlay
        (final: prev: {
          wallpaper-engine-kde = plasma5Packages.callPackage ./overlays/wallpaper-engine-kde.nix {
            inherit (gst_all_1) gst-libav; 
            inherit (python3Packages) websockets; 
          };
        })
        (final: prev: { adw-gtk3 = prev.callPackage ./overlays/adw-gtk.nix {}; })
      ];

      nixosConfigurations.xianzhou = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = { inherit inputs; };

        modules = [
          ./hosts
          ./hosts/plasma.nix
          
          home-manager.nixosModules.home-manager 
        ];

      };

      nixosConfigurations.liyue = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = { inherit inputs; };

        modules = [
          ./hosts
          ./hosts/gnome.nix

          home-manager.nixosModules.home-manager 
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
