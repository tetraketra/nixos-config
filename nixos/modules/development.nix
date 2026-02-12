{ config, pkgs-stable, ... }:

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
            ] ++ pkgs-stable.vscode-utils.extensionsFromVscodeMarketplace [
                # RMB Extension
                # > Download Specific Version VSIX
                # > `openssl dgst -sha256 -binary [YOUR_FILE_HERE] | openssl base64 -A` 
                # > "sha2560-[YOUR_THING_HERE]"
                {
                    name = "python-envy";
                    publisher = "teticio";
                    version = "0.1.11";
                    sha256 = "sha256-grkusc1UWWxpD25f4bnoBSumjwKuIum+jRMJ+gt1d94=";
                }
                {
                    name = "doxygen";
                    publisher = "bbenoist";
                    version = "1.0.0";
                    sha256 = "sha256-FhH+pi2lVD7pZJMa4znJDz3S7Zqw8ltpYUMqW4FZlE0=";
                }
                {
                    name = "outline-map";
                    publisher = "gerrnperl";
                    version = "1.4.2";
                    sha256 = "sha256-F1JmOxyfa9u2sEWiW2esHRONUNYRjME/X/KJ33MaW/M=";
                }
                {
                    name = "shader";
                    publisher = "slevesque";
                    version = "1.1.5";
                    sha256 = "sha256-Pf37FeQMNlv74f7LMz9+CKscF6UjTZ7ZpcaZFKtX2ZM=";
                }
            ];
        })
    ];
    environment.sessionVariables = {
        RUST_SRC_PATH = "${pkgs-stable.rust.packages.stable.rustPlatform.rustLibSrc}";
    };
}