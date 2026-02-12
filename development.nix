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
        vscode-with-extensions
        gnumake
        git
        github-desktop
    ];

    environment.sessionVariables = {
        RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    };

    environment.systemPackages = with pkgs; [(
        vscode-with-extensions.override {
            vscodeExtensions = with vscode-extensions; [
                usernamehw.errorlens
                bbenoist.doxygen
                gerrnperl.outline-map
                tamasfe.even-better-toml
                file-icons.file-icons
                slevesque.shade
                vadimcn.vscode-lldb
                # SQL.
                adpyke.vscode-sql-formatter
                qwtel.sqlite-viewer
                # Nix.
                bbenoist.nix
                # C.
                ms-vscode.cpptools-extension-pack
                mesonbuild.mesonbuild
                # Python.
                charliermarsh.ruff
                ms-python.python
                teticio.python-envy
                # Rust.
                (vscode-extensions."1yib.rust-bundle")
                dustypomerleau.rust-syntax
                jscearcy.rust-doc-viewer
                
            ];
        }
    )];
}