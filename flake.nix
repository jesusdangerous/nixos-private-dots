{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    # Второй пакетный набор. По умолчанию тоже стабильный.
    nixpkgs2.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming = { # Удобно ставить некоторые игры
      url = "github:fufexan/nix-gaming"; 
      # inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: 
  let
    system = "x86_64-linux";
    username = "sixxxsta";
    user = {
      inherit username;
      homeDirectory = "/home/${username}";
      git = {
        name = "username";
        email = "username@example.com";
      };
    };
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "python-2.7.18.8"
        "electron-25.9.0"
      ];
    };
    pkgs = import nixpkgs {
      inherit system;
      inherit config;
    };
    pkgs2 = import inputs.nixpkgs2 {
      inherit system;
      inherit config;
    };
    spkgs = import inputs.nixpkgs-stable {
      inherit system;
      inherit config;
    };
  in
  {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit spkgs; inherit pkgs2; inherit inputs; inherit user; };
        inherit pkgs;
        inherit system;
        modules = [
          ./nixos/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
        ];
      };
    };
  };
}
