{
    description = "Tetra's Home Manager Configuration";

    inputs = {
        nixpkgs-stable.url = "nixpkgs/nixos-25.11";
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager/release-25.11";
            inputs.nixpkgs.follows = "nixpkgs-stable";
        };
    };

    outputs = { 
        nixpkgs-stable, 
        nixpkgs-unstable, 
        home-manager, 
        ... 
    }@inputs:
    let
        system = "x86_64-linux";
        pkgs = nixpkgs: import nixpkgs { inherit system; config.allowUnfree = true; };
        version = builtins.trim (builtins.readFile ./.host-selection);
        hostSelection = "./nixos/hosts/${version}/hardware-configuration.nix";
    in {
        pkgs-stable = pkgs inputs.nixpkgs-stable;
        pkgs-unstable = pkgs inputs.nixpkgs-unstable;

        nixosConfigurations = {
            myNixos = nixpkgs-stable.lib.nixosSystem {
                specialArgs = { 
                    inherit inputs hostSelection pkgs-stable pkgs-unstable; 
                };
                modules = [ ./nixos/configuration.nix ];
            };
        };
    };
}
