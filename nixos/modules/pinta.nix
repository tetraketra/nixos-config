{ config, inputs, pkgs-unstable, pkgs-stable, lib, ... }:

let
    pinta-pkg = import inputs.nixpkgs-pinta {
        system = pkgs-unstable.stdenv.hostPlatform.system;
    };
in
{
    home.packages = [
        pinta-pkg.pinta
    ];
}
