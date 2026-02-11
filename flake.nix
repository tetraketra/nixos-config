{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
  };
  outputs = { self, nixpkgs }@attrs: {
    nixosConfigurations.motoko = nixpkgs.lib.nixosSystem rec {
      pkgs = import nixpkgs { inherit system; config = { allowUnfree = true; };};
      system = "x86_64-linux";
      modules = [ ./configuration.nix
                  # This fixes nixpkgs (for e.g. "nix shell") to match the system nixpkgs
                  ({ config, pkgs, options, ... }: { nix.registry.nixpkgs.flake = nixpkgs; })
                ];
    };
  };
}