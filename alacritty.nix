{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        alacritty
        alacritty-theme
    ];

    alacritty.enable = true;
    alacritty-theme.enable = true;

    programs.dconf.profiles.user.databases = [{
        settings = {
            "org/cinnamon/desktop/default-applications/terminal" = {
                exec = "alacritty";
                exec-arg = "-e";
            };
        };
    }];
}