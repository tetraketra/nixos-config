{ config, pkgs-stable, ... }:

let
    image-types = [ "png" "jpeg" "jpg" "gif" "svg+xml" "bmp" "webp" "tiff" "x-icon" "vnd.microsoft.icon" "heif" "heic" "avif" "x-pcx" "x-pnm" "x-portable-bitmap" "x-portable-graymap" "x-portable-pixmap" "x-xbitmap" "x-xpixmap" ];
    image-formats = map (type: "image/${type}") image-types;

    # Where `bind-list` like `[ {binding="", command="", name=""}, {...similar...}, ... ]`.
    keybinds-generator = bind-list: 
        let
            lists = pkgs-stable.lib.lists;
            custom-names = (map (i: "'custom${toString i}'") (lists.range 0 (builtins.length bind-list - 1)));
            custom-str = builtins.concatStringsSep ", " custom-names;
            custom-zipped = lists.zipListsWith (n: b: { name=n; bind=b; }) custom-names bind-list;

            settings = {
                "org/cinnamon/desktop/keybindings" = {
                    custom-list = "[${custom-str}]";
                };
            } // builtins.listToAttrs (
                map (item: {
                    name = "org/cinnamon/desktop/keybindings/custom-keybindings/${item.name}";
                    value = {
                        binding = item.bind.binding;
                        command = item.bind.command;
                        name = item.bind.name;
                    };
                }) custom-zipped
            );
        in
            settings
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
        # TODO: TO BE CONVERTED TO HOME-MANAGER ACTUAL USER PROFILE (*NOT JUST DEFAULTS*)
        settings = {
            "org/cinnamon/desktop/applications/terminal" = {
                exec = "alacritty";
                exec-arg = "--";
            };

            "org/cinnamon/desktop/applications/calculator" = {
                exec = "qalculate-gtk";
            };            
        } // keybinds-generator [
            { binding="['<Primary><Alt>t']"; command="alacritty -e"; name="Launch Alacritty"; }
            { binding="['<Primary><Alt>f']"; command="firefox"; name="Launch Firefox"; }
            { binding="['<Primary><Alt>c']"; command="qalculate-gtk"; name="Launch Qalculate-GTK (C)"; }
            { binding="['<Primary><Alt>q']"; command="qalculate-gtk"; name="Launch Qalculate-GTK (Q)"; }
        ];

    }];

    xdg.mime.defaultApplications = builtins.listToAttrs (
        map (format: { name = format; value = "gimp.desktop"; }) image-formats
    ) // {
        "application/pdf" = "firefox.desktop";
        "text/plain" = "code.desktop";
        "text/html" = "firefox.desktop";
    };
}