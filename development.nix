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
        gnumake
        git
        github-desktop
        (vscode-with-extensions.override {
            vscodeExtensions = with vscode-extensions; [
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
            ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
                {
                    name = "python-envy";
                    publisher = "teticio";
                    version = "0.1.11";
                    sha256 = "82b92eb1cd54596c690f6e5fe1b9e8052ba68f02ae22e9be8d1309fa0b7577de";
                }
            ];
        })
    ];
    environment.sessionVariables = {
        RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    };
}