{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        # C.
        nix-ld
        libgcc
        glib
        glibc
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
        # Dev.
        vscode
        gnumake
        git
        github-desktop
    ];

    programs.vscode = {
        enable = true;
        mutableExtensionsDir = false;
        extensions = with pkgs.vscode-extensions; [
            usernamehw.errorlens
            tamasfe.even-better-toml
            file-icons.file-icons
            # Nix.
            bbenoist.nix
            # C.
            ms-vscode.cpptools-extension-pack
            mesonbuild.mesonbuild
            # Python.
            charliermarsh.ruff
            ms-python.python
            # Rust.
            rust-lang.rust-analyzer
            serayuzgur.crates
            njpwerner.autodocstring
        ];
    };

    environment.sessionVariables = {
        RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    };
}