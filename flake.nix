{
  description = "Nixos config flake";
  nixConfig = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    extra-substituters = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-index-database.url = "github:nix-community/nix-index-database";

    stylix.url = "github:danth/stylix";
    sops-nix.url = "github:Mic92/sops-nix";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixGL = {
      url = "github:nix-community/nixGL/310f8e49a149e4c9ea52f1adf70cdc768ec53f8a";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:confusedalex/nixvim";

    nur.url = "github:nix-community/NUR";
    jovian.url = "github:Jovian-Experiments/Jovian-NixOS";
    ghostty.url = "github:ghostty-org/ghostty";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      systems,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs (import systems) (
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
      );
    in
    {
      inherit lib;
      overlays = import ./overlays { inherit inputs; };
      formatter = forEachSystem (pkgs: pkgs.nixfmt-rfc-style);

      # NixOS configuration entrypoint
      nixosConfigurations = {
        proba = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            { nixpkgs.overlays = [ inputs.nur.overlay ]; }
            ./hosts/proba/configuration.nix
          ];
        };
        gaia = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./hosts/gaia/configuration.nix ];
        };
        rosetta = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./hosts/rosetta/configuration.nix ];
        };
      };

      homeConfigurations = {
        # Standalone HM only
        # private laptop
        "alex@proba" = lib.homeManagerConfiguration {
          modules = [
            ./home/proba.nix
            { nixpkgs.overlays = [ inputs.nur.overlay ]; }
          ];
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          pkgs = pkgsFor.x86_64-linux;
        };
        "alex@rosetta" = lib.homeManagerConfiguration {
          modules = [ ./home/rosetta.nix ];
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          pkgs = pkgsFor.x86_64-linux;
        };
        "alex@gaia" = lib.homeManagerConfiguration {
          modules = [ ./home/gaia.nix ];
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          pkgs = pkgsFor.x86_64-linux;
        };
      };
    };
}
