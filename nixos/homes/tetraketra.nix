{ config, lib, inputs, pkgs-unstable, pkgs-stable, ... }:

let
    files = [
        ../modules/pinta.nix
        ../modules/keybinds.nix
        ../modules/startup-apps.nix
        ../modules/brightness.nix
        ../modules/dotfiles.nix
    ];

    configs = map (f: import f { inherit config lib inputs pkgs-stable pkgs-unstable; }) files;
    merged = lib.foldl (a: b: lib.recursiveUpdate a b) {} configs;
in
merged
