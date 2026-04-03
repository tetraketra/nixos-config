{ config, lib, pkgs-stable, ... }:

let
    enable-on-targets = [ "hp-envy" ];
    should-bright = builtins.elem (builtins.getEnv "TARGET") enable-on-targets;
in
{
    systemd.timers."set-gamma" = lib.mkIf should-bright {
        wantedBy = [ "timers.target" ];
        timerConfig = {
            OnBootSec = "5m";
            OnUnitActiveSec = "5m";
            Unit = "set-gamma.service";
        };
    };

    systemd.services."set-gamma" = lib.mkIf should-bright {
        script = ''
            ${pkgs-stable.xorg.xrandr} --output eDP-1 --brightness 1.5
        '';
        serviceConfig = {
            Type = "oneshot";
            User = "root";
            RemainAfterExit = true;
        };
    };

}