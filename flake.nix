{
    description = "Tetra's Home Manager Configuration";

    inputs = {
        nixpkgs-stable.url = "nixpkgs/nixos-25.11";
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager/release-25.11";
            inputs.nixpkgs.follows = "nixpkgs-stable";
        };

        nixpkgs-pinta.url = "github:NixOS/nixpkgs/f366af7a1b3891d9370091ab03150d3a6ee138fa";
    };

    outputs = { 
        nixpkgs-stable, 
        nixpkgs-unstable, 
        home-manager, 
        ... 
    }@inputs:
    let
        system = "x86_64-linux";
        pkgs-generator = nixpkgs: import nixpkgs { inherit system; config.allowUnfree = true; };
        target-selection = ./. + "/nixos/targets/${builtins.getEnv "TARGET"}/hardware-configuration.nix";
        pkgs-stable = pkgs-generator inputs.nixpkgs-stable;
        pkgs-unstable = pkgs-generator inputs.nixpkgs-unstable;
    in {
        nixosConfigurations = {
            myNixos = nixpkgs-stable.lib.nixosSystem {
                specialArgs = { 
                    inherit inputs target-selection pkgs-stable pkgs-unstable; 
                };
                modules = [ ./nixos/configuration.nix ];
            };
        };
    };
}
