{ config, pkgs, ... }:

{
    services.xserver.desktopManager.cinnamon.enable = true;
    services.cinnamon.apps.enable = true;

    environment.systemPackages = with pkgs; [
        dconf
        mint-themes
        mint-l-icons
        mint-cursor-themes
    ];

    programs.dconf.enable =true;
    
    qt = {
        enable = true;
        platformTheme = "gnome";
    };

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
}
