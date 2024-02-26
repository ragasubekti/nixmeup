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
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nix-software-center.url = "github:snowfallorg/nix-software-center";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    # sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { self, nixpkgs, home-manager, nur, nixpkgs-stable, chaotic
    , nix-flatpak, ... }@inputs:
    let
      system = "x86_64-linux";
      home-user = "guinaifen";

      pkgs-stable = import nixpkgs-stable {
        inherit system;
        config = { allowUnfree = true; };
      };

      home-manager-setting = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;

        home-manager.extraSpecialArgs = {
          inherit inputs pkgs-stable home-user;
        };
        home-manager.users.${home-user} = import ./home;
      };
    in {

      nixosConfigurations.xianzhou = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = { inherit inputs home-user; };

        modules = [
          chaotic.nixosModules.default
          nix-flatpak.nixosModules.nix-flatpak

          ./hosts
          ./hosts/plasma.nix

          ./overlays

          home-manager.nixosModules.home-manager
          home-manager-setting
        ];

      };

      nixosConfigurations.liyue = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = { inherit inputs home-user; };

        modules = [
          chaotic.nixosModules.default
          nix-flatpak.nixosModules.nix-flatpak
          # sops-nix.nixosModules.sops

          ./hosts
          ./hosts/gnome.nix

          ./overlays

          home-manager.nixosModules.home-manager
          home-manager-setting
        ];

      };

      # devShells.${system} = import ./develop { inherit pkgs; };
    };
}
