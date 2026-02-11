{ config, pkgs, ... }:

{
    services.xserver.desktopManager.cinnamon.enable = true;
    services.cinnamon.apps.enable = true;

    users.users.tetraketra.packages = with pkgs; [
        mint-themes
        mint-l-icons
        mint-cursor-themes
    ];

    environment.cinnamon.excludePackages = with pkgs; [
        celluloid
        gnome-color-manager
        gnome-calendar
        xviewer
        onboard
        gnome-online-accounts
        gnome-screenshot
        warpinator

    ];

    dconf.settings = {
        "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
        };
    };

    gtk = {
        enable = true;
        theme = {
            name = "Adwaita-dark";
            package = pkgs.gnome.gnome-themes-extra;
        };
    };

    qt = {
        enable = true;
        style = "adwaita-dark";
    };
}
  