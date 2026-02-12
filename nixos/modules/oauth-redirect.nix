{ config, pkgs-stable, ... }:

{
  xdg = {
    autostart.enable = true;
    portal = {
      xdgOpenUsePortal = true;
      enable = true;
      extraPortals = [
        pkgs-stable.xdg-desktop-portal-xapp
      ];
    };
  }; 

  environment.systemPackages = with pkgs; [
    xdg-utils
    xdg-desktop-portal-xapp
  ];
} 