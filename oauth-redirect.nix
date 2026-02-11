{ config, pkgs, ... }:

{
  xdg = {
    autostart.enable = true;
    portal = {
      xdgOpenUsePortal = true;
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  }; 

  environment.systemPackages = with pkgs; [
    xdg-utils
  ];
} 