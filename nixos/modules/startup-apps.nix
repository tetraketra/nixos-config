{ config, lib, inputs, pkgs-unstable, pkgs-stable, ... }:

{
    home.file.".config/autostart/vesktop.desktop".text = ''
        [Desktop Entry]
        Type=Application
        Exec=vesktop
        Hidden=false
        NoDisplay=false
        X-GNOME-Autostart-enabled=true
        Name=Vesktop
    '';

    home.file.".config/autostart/firefox.desktop".text = ''
        [Desktop Entry]
        Type=Application
        Exec=firefox
        Hidden=false
        NoDisplay=false
        X-GNOME-Autostart-enabled=true
        Name=Firefox
    '';

    home.file.".config/autostart/github-desktop.desktop".text = ''
        [Desktop Entry]
        Type=Application
        Exec=github-desktop
        Hidden=false
        NoDisplay=false
        X-GNOME-Autostart-enabled=true
        Name=GitHub Desktop
    '';
}