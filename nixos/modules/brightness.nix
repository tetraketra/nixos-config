{ config, lib, pkgs-stable, ... }:

let
    enable-on-targets = [ "hp-envy" ];
    should-bright = builtins.elem (builtins.getEnv "TARGET") enable-on-targets;
in
{
    systemd.timers."set-gamma" = lib.mkIf should-bright {
        wantedBy = [ "timers.target" ];
        timerConfig = {
            OnBootSec = "2m";
            OnUnitActiveSec = "2m";
            Unit = "set-gamma.service";
        };
    };

    systemd.services."set-gamma" = lib.mkIf should-bright {
        wantedBy = [ "graphical.target" ];
        after = [ "graphical.target" ];
        restartIfChanged = true;
        script = ''
            ${pkgs-stable.xorg.xrandr}/bin/xrandr --output eDP-1 --brightness 2
        '';
        serviceConfig = {
            Type = "oneshot";
            User = "tetraketra";
            RemainAfterExit = true;
        };
    };

}