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
                jgclark.vscode-todo-highlight
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
                fill-labs.dependi
                njpwerner.autodocstring
            ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
                {
                    name = "python-envy";
                    publisher = "teticio";
                    version = "0.1.11";
                    sha256 = "82b92eb1cd54596c690f6e5fe1b9e8052ba68f02ae22e9be8d1309fa0b7577de";
                }
                {
                    name = "doxygen";
                    publisher = "bbenoist";
                    version = "1.0.0";
                    sha256 = "1611fea62da5543ee964931ae339c90f3dd2ed9ab0f25b6961432a5b8159944d";
                }
                {
                    name = "outline";
                    publisher = "gerrnperl";
                    version = "1.4.2";
                    sha256 = "1752663b1c9f6bdbb6b045a25b67ac1d138d50d6118cc13f5ff289df731a5bf3";
                }
                {
                    name = "shader";
                    publisher = "slevesque";
                    version = "1.1.5";
                    sha256 = "3dfdfb15e40c365bfbe1fecb333f7e08ab1c17a5234d9ed9a5c69914ab57d993";
                }
            ];
        })
    ];
    environment.sessionVariables = {
        RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    };
}