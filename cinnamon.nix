{ config, pkgs, ... }:

{
    # Setup.
    services.xserver.desktopManager.cinnamon.enable = true;
    services.cinnamon.apps.enable = true;

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

    # Theming.
    environment.systemPackages = with pkgs; [
        dconf
        mint-themes
        mint-l-icons
        mint-cursor-themes
        gnome-tweaks
    ];

    programs.dconf.enable = true;
    programs.dconf.profiles.user.databases = [{
        settings = {
            "org/cinnamon/desktop/interface" = {
                gtk-theme = "Mint-Y-Dark-Teal";
                icon-theme = "Mint-L-Teal";
            };

            "org/cinnamon/desktop/wm/preferences" = {
                theme = "Mint-Y-Dark-Teal";
            };

            "org/gnome/desktop/interface" = {
                color-scheme = "prefer-dark";
            };

            "org/x/apps/portal" = {
                color-scheme = "prefer-dark";
            };
        };
    }];

    qt = {
        enable = true;
        style = "adwaita-dark";
        platformTheme = "gnome";
    };
}
