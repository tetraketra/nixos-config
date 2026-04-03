{ config, lib, inputs, pkgs-unstable, pkgs-stable, ... }:

{
    xdg.configFile."autostart/vesktop.desktop".text = ''
        [Desktop Entry]
        Type=Application
        Exec=vesktop
        Hidden=false
        NoDisplay=false
        X-GNOME-Autostart-enabled=true
        Name=Vesktop
    '';

    xdg.configFile."autostart/firefox.desktop".text = ''
        [Desktop Entry]
        Type=Application
        Exec=firefox
        Hidden=false
        NoDisplay=false
        X-GNOME-Autostart-enabled=true
        Name=Firefox
    '';

    xdg.configFile."autostart/github-desktop.desktop".text = ''
        [Desktop Entry]
        Type=Application
        Exec=github-desktop
        Hidden=false
        NoDisplay=false
        X-GNOME-Autostart-enabled=true
        Name=GitHub Desktop
    '';
}
