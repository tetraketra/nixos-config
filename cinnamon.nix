{ config, pkgs, ... }:

{
    services.xserver.desktopManager.cinnamon.enable = true;
    services.cinnamon.apps.enable = true;

    environment.systemPackages = with pkgs; [
        dconf
        gtk
        qt
    ];

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

    programs.dconf.enable = true;
    programs.dconf.profiles.user.databases = [{
        lockAll = true;
        settings = {
            "org/gnome/desktop/interface" = {
                color-scheme = "prefer-dark";
            };
        };
    }];

    environment.variables = {
        GTK_THEME = "Adwaita:dark";
        ADW_DISABLE_PORTAL = "1";
        QT_STYLE_OVERRIDE = "adwaita-dark";
    };

    programs.qt = {
        enable = true;
        platformTheme.name = "gnome";
        style.name = "adwaita-dark";
    };
}
