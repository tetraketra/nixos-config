{
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-25.11";
        home-manager = {
            url = "github:nix-community/home-manager";
            input.nixplgs.follows = "nixpkgs";
        };
    };
    outputs = { self, nixpkgs, home-manager }@attrs: {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
            pkgs = import nixpkgs { inherit system; config = { allowUnfree = true; };};
            system = "x86_64-linux";
            modules = [ 
                ./configuration.nix
                ({ config, pkgs, options, ... }: { nix.registry.nixpkgs.flake = nixpkgs; })
            ];
        };
    };
}