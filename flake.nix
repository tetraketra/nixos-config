{
    description = "Tetra's Home Manager Configuration";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-25.11";

        home-manager = {
            url = "github:nix-community/home-manager/release-25.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { nixpkgs, home-manager, ... }@inputs:
    let
        lib = nixpkgs.lib;
        system = "x86_64-linux";
        pkgs = import nixpkgs { 
            inherit inputs system; 
            conifg = {
                allowUnfree = true;
            };
        };
    in 
    {
        nixosConfigurations = {
            myNixos = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit inputs system; };
                modules = [ ./configuration.nix ];
            };
        };
    };
}
