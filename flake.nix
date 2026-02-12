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
        lib = nixpkgs.lib;
        system = "x86_64-linux";
        pkgs-unstable = import inputs.nixpkgs-unstable {
            system = "x86_64-linux";
            config = {
                allowUnfree = true;
            };
        };
        pkgs-stable = import inputs.nixpkgs-stable {
            system = "x86_64-linux";
            config = {
                allowUnfree = true;
            };
        };
        version = builtins.replaceStrings ["\n"] [""] (builtins.readFile ./.host-selection);
        hostSelection = ./. + "/nixos/hosts/${version}/hardware-configuration.nix";
    in {
        nixosConfigurations = {
            myNixos = nixpkgs.lib.nixosSystem {
                specialArgs = { 
                    inherit 
                    inputs 
                    system 
                    hostSelection
                    pkgs-stable
                    pkgs-unstable
                    ; 
                };
                modules = [ ./nixos/configuration.nix ];
            };
        };
    };
}
