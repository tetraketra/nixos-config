{ config, pkgs-stable, ... }:

let
    version = builtins.replaceStrings ["\n"] [""] (builtins.readFile ../../.host-selection);
    enable-on-hosts = [ "hp-envy" ];
in 
{
    systemd.timers."set-gamma" = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
            OnBootSec = "5m";
            OnUnitActiveSec = "5m";
            Unit = "set-gamma.service";
        };
    };

    systemd.services."set-gamma" = {
        script = ''
            set -eu
            ${pkgs-stable.xorg.xrandr} --output eDP-1 --brightness 1.5"
        '';
        serviceConfig = {
            Type = "oneshot";
            User = "root";
            RemainAfterExit = true;
        };
    };

}