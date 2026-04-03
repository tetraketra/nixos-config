{ config, lib, inputs, pkgs-unstable, pkgs-stable, ... }:

let
    startup-generator = { command, name, filename }: ''
        [Desktop Entry]
        Type=Application
        Exec=${command}
        Hidden=false
        NoDisplay=false
        X-GNOME-Autostart-enabled=true
        Name=${name}
    '';

    autostart-apps = [
        { name = "Vesktop"; command = "vesktop"; filename="vesktop"; }
        { name = "Firefox"; command = "firefox"; filename="firefox"; }
        { name = "GitHub Desktop"; command = "github-desktop"; filename="github-desktop"; }
    ];
in
{
    home.file = builtins.listToAttrs (map app: {
        name = ".config/autostart/${app.filename}.desktop";
        value.text = startup-generator app;
    } autostart-apps);
}