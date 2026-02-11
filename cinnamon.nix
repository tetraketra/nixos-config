{ config, pkgs, ... }:

{
  services.xserver.desktopManager.cinnamon.enable = true;
  services.cinnamon.apps.enable = false;

  users.users.tetraketra.packages = with pkgs; [
    mint-themes
    mint-l-icons
    mint-cursor-themes
  ];
}
  