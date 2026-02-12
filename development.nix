{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        # C.
        nix-ld
        libgcc
        # Rust.
        cargo
        rustc
        rustfmt
        clippy
        rust-analyzer
        # Python.
        python312
        uv
        # Games.
        sdl3
        SDL2
        glfw
        raylib
    ];

    environment.sessionVariables = {
        RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    };
}