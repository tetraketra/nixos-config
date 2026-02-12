{ config, pkgs-stable, ... }:

let
    image-types = [ "png" "jpeg" "jpg" "gif" "svg+xml" "bmp" "webp" "tiff" "x-icon" "vnd.microsoft.icon" "heif" "heic" "avif" "x-pcx" "x-pnm" "x-portable-bitmap" "x-portable-graymap" "x-portable-pixmap" "x-xbitmap" "x-xpixmap" ];
    image-formats = map (type: "image/${type}") image-types;

    # Where `bind-list` like `[ {binding="", command="", name=""}, {...similar...}, ... ]`.
    keybinds-generator = bind-list: 
        let
            custom-names = (map (i: "'custom${i}'") (builtins.range 0 (builtins.length bind-list - 1)));
            custom-str = builtins.concatStringsSep ", " custom-names;
            settings = {
                "org/cinnamon/desktop/keybindings" = {
                    custom-list = "[${custom-str}]";
                };
            };
            
            zipped = zipListsWith () custom-names bind-list;
            builtins.trace "Debug message: ${toString zipped}" zipped
            # } // builtins.listToAttrs (
            #     map ()
            # );

        in
            settings
            # "org/cinnamon/desktop/keybindings/custom-keybindings/custom0" = {
            #     binding="['<Primary><Alt>t']";
            #     command="alacritty -e";
            #     name="Launch Alacritty";
            # };
    ;
in
{
    environment.systemPackages = with pkgs-stable; [
        alacritty
        alacritty-theme
        gimp2-with-plugins
        qalculate-gtk
        vlc
    ];

    programs.dconf.profiles.user.databases = [{
        # TODO: SOON TO BE CONVERTED TO HOME-MANAGER ACTUAL USER PROFILE (*NOT JUST DEFAULTS*)
        settings = {
            "org/cinnamon/desktop/applications/terminal" = {
                exec = "alacritty";
                exec-arg = "--";
            };

            "org/cinnamon/desktop/keybindings" = {
                custom-list = "['custom0']";
            };

            "org/cinnamon/desktop/keybindings/custom-keybindings/custom0" = {
                binding="['<Primary><Alt>t']";
                command="alacritty -e";
                name="Launch Alacritty";
            };

            "org/cinnamon/desktop/applications/calculator" = {
                exec = "qalculate-gtk";
            };
        };

    }];

    xdg.mime.defaultApplications = builtins.listToAttrs (
        map (format: { name = format; value = "gimp.desktop"; }) image-formats
    ) // {
        "application/pdf" = "firefox.desktop";
        "text/plain" = "code.desktop";
        "text/html" = "firefox.desktop";
    };
}