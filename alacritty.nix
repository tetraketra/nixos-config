{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        alacritty
        alacritty-theme
    ];

    programs.dconf.profiles.user.databases = [{
        settings = {
            "org/cinnamon/desktop/keybindings/custom-keybindings/custom0" = {
                binding = ["<Primary><Alt>t"];
                command = "alacritty";
                name = "open-terminal";
            };
            
            "org/cinnamon/desktop/keybindings/custom-list" = [
                "/org/cinnamon/desktop/keybindings/custom-keybindings/custom0/"
            ];
        };
    }];
}