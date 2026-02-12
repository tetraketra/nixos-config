{ config, pkgs-stable, ... }:

let
    image-types = [ "png" "jpeg" "jpg" "gif" "svg+xml" "bmp" "webp" "tiff" "x-icon" "vnd.microsoft.icon" "heif" "heic" "avif" "x-pcx" "x-pnm" "x-portable-bitmap" "x-portable-graymap" "x-portable-pixmap" "x-xbitmap" "x-xpixmap" ];
    image-formats = map (type: "image/${type}") image-types;

    keybindings = [
        { binding=["<Primary><Alt>t"]; command="alacritty -e"; name="Launch Alacritty"; }
        { binding=["<Primary><Alt>f"]; command="firefox"; name="Launch Firefox"; }
        { binding=["<Primary><Alt>c"]; command="qalculate-gtk"; name="Launch Qalculate-GTK (C)"; }
        { binding=["<Primary><Alt>q"]; command="qalculate-gtk"; name="Launch Qalculate-GTK (Q)"; }
    ];

    custom-names = map (i: "custom${toString i}") (builtins.range 0 (builtins.length keybindings - 1));
    zipped = pkgs-stable.lib.lists.zipListsWith (name: bind: { name=name; bind=bind; }) custom-names keybindings;

    generated-keybinds = {
        "org/cinnamon/desktop/keybindings" = { custom-list = custom-names; };
    } // builtins.listToAttrs (
        map (item: {
            name = "org/cinnamon/desktop/keybindings/custom-keybindings/${item.name}";
            value = {
                binding = item.bind.binding;
                command = item.bind.command;
                name = item.bind.name;
            };
        }) zipped
    );
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
        } // generated-keybinds;
    }];

    xdg.mime.defaultApplications = builtins.listToAttrs (
        map (format: { name = format; value = "gimp.desktop"; }) image-formats
    ) // {
        "application/pdf" = "firefox.desktop";
        "text/plain" = "code.desktop";
        "text/html" = "firefox.desktop";
    };
}