{ config, pkgs, ... }:

{
  xdg = {
    autostart.enable = true;
    portal = {
      xdgOpenUsePortal = true;
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-xapp
      ];
    };
  }; 

  environment.systemPackages = with pkgs; [
    xdg-utils
    xdg-desktop-portal-gtk
    xdg-desktop-portal-xapp
  ];
} 