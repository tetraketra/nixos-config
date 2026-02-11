{ pkgs, ... }:
{
    gtk = {
        enable = true;
        theme = {
            name = "Ad-dark";
            package = pkgs.materia-theme;
        };
        iconTheme = {
            name = "Papirus-Dark";
            package = pkgs.papirus-icon-theme;
        };
    };
}
