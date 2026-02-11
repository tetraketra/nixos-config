{ config, pkgs, ... }:

{
  xdg = {
    autostart.enable = true;
    portal = {
      xdgOpenUsePortal = true;
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-xapp
      ];
    };
  }; 

  environment.sessionVariables = {
    XDG_SESSION_TYPE = "x11";
    XDG_CURRENT_DESKTOP = "X-Cinnamon";
    XDG_SESSION_DESKTOP = "X-Cinnamon";
    GTK_USE_PORTAL = "1";
  };

  environment.systemPackages = with pkgs; [
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    # xdg-desktop-portal-xapp
  ];
}
  