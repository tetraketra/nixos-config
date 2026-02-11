{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        alacritty
        alacritty-theme
    ];

    programs.dconf.profiles.user.databases = [{
        settings = {
            "org/cinnamon/desktop/applications/terminal" = {
                exec = "alacritty";
                exec-arg = "-e";
            };

            "org/cinnamon/desktop/applications/calculator" = {
                exec = "qalculate-gtk";
            };
        };
        
    }];

    xdg.mime.defaultApplications = {
        "application/pdf" = "firefox.desktop";
        "image/png" = "gimp.desktop";
        "image/jpeg" = "gimp.desktop";
        "image/gif" = "gimp.desktop";
        "image/svg+xml" = "gimp.desktop";
        "image/bmp" = "gimp.desktop";
        "image/webp" = "gimp.desktop";
        "text/plain" = "code.desktop";
        "text/html" = "firefox.desktop";
    };
}