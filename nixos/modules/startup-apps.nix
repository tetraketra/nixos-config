{ config, lib, inputs, pkgs-unstable, pkgs-stable, ... }:

let
    startup-generator = command: name: ''
        [Desktop Entry]
        Type=Application
        Exec=${command}
        Hidden=false
        NoDisplay=false
        X-GNOME-Autostart-enabled=true
        Name=${name}
    '';

    autostart-apps = [
        ( startup-generator "Vesktop" "vesktop" )
        ( startup-generator "Firefox" "firefox" )
        ( startup-generator "GitHub Desktop" "github-desktop" )
    ];
in
{
    home.file = builtins.listToAttrs (map app: {
        ".config/autostart/${lib.strings.replaceChars " " "-" app.name}.desktop"
        value.text = startup-generator app
    } autostart-apps);
}