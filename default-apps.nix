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
                exec-arg = "--";
            };

            "org/cinnamon/desktop/keybindings" = {
                custom-list = "['custom0']";
            };

            "org/cinnamon/desktop/keybindings/custom-keybindings/custom0" = {
                binding="['<Primary><Alt>t']";
                command="alacritty -e";
                name="Launch Alacritty";
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