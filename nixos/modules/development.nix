{ config, pkgs-stable, ... }:

let
    extension-generator = publisher: name: version: sha256: {
        name = name;
        publisher = publisher;
        version = version;
        sha256 = sha256;
    };
in
{
    environment.systemPackages = with pkgs-stable; [
        # == c/cpp =====
        nix-ld
        libgcc
        glib
        glibc

        # == rust ======
        cargo
        rustc
        rustfmt
        clippy
        rust-analyzer

        # == python ====
        python312
        uv

        # == games =====
        sdl3
        SDL2
        glfw
        raylib

        # == misc dev ==
        gnumake
        git
        github-desktop

        # == vscode ====
        (vscode-with-extensions.override {
            vscodeExtensions = with vscode-extensions; [
                # == nix =====
                bbenoist.nix

                # == c/cpp ===
                ms-vscode.cpptools-extension-pack
                mesonbuild.mesonbuild

                # == python ==
                charliermarsh.ruff
                ms-python.python

                # == rust ====
                rust-lang.rust-analyzer
                fill-labs.dependi
                njpwerner.autodocstring

                # == misc ====
                usernamehw.errorlens
                tamasfe.even-better-toml
                file-icons.file-icons
                jgclark.vscode-todo-highlight
            ] ++ pkgs-stable.vscode-utils.extensionsFromVscodeMarketplace [
                # 1. RMB Extension > Download Specific Version VSIX
                # 2. openssl dgst -sha256 -binary [YOUR_FILE_HERE] | openssl base64 -A
                # 3. sha2560-[YOUR_THING_HERE]
                (extension-generator "teticio" "python-envy" "0.1.11" "sha256-grkusc1UWWxpD25f4bnoBSumjwKuIum+jRMJ+gt1d94=")
                (extension-generator "bbenoist" "doxygen" "1.0.0" "sha256-FhH+pi2lVD7pZJMa4znJDz3S7Zqw8ltpYUMqW4FZlE0=")
                (extension-generator "gerrnperl" "outline-map" "1.4.2" "sha256-F1JmOxyfa9u2sEWiW2esHRONUNYRjME/X/KJ33MaW/M=")
                (extension-generator "slevesque" "shader" "1.1.5" "sha256-Pf37FeQMNlv74f7LMz9+CKscF6UjTZ7ZpcaZFKtX2ZM=")
                (extension-generator "ivangabriele" "vscode-git-add-and-commit" "2.1.1" "sha256-5z90NqxzCtiWj6zJqoQvnGzk0WMiVLLXmk0oHzsjXEI=%")
            ];
        })
    ];

    environment.sessionVariables.RUST_SRC_PATH = "${pkgs-stable.rust.packages.stable.rustPlatform.rustLibSrc}";
}