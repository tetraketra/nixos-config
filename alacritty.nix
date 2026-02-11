{ config, pkgs, ... }:

{
    environment.cinnamon.excludePackages = with pkgs; [
        alacritty
        alacritty-theme
    ];

    programs.dconf.profiles.user.databases = [{
        settings = {
            "org/cinnamon/desktop/default-applications/terminal" = {
                exec = "alacritty";
                exec-arg = "-e";
            };
        };
    }];
}