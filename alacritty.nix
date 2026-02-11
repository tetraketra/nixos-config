{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        alacritty
        alacritty-theme
    ];
    
    programs.dconf.profiles.user.databases = [{
        settings = {
            "org/gnome/desktop/default-applications/terminal" = {
                exec = "alacritty";
                exec-arg = "-e";
            };
        };
    }];
}