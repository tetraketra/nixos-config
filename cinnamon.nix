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
        color
        calendar
        xviewer
        onboard
        gnome-online-accounts
        screenshot
        warpinator
        
    ];
}
  