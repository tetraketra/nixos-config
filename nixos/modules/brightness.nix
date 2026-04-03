{ config, lib, pkgs-stable, ... }:

let
    enable-on-targets = [ "hp-envy" ];
    should-bright = builtins.elem (builtins.getEnv "TARGET") enable-on-targets;
in
{
    systemd.user.services."set-gamma" = lib.mkIf should-bright {
        description = "Set screen brightness via xrandr";

        wantedBy = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];

        serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs-stable.xorg.xrandr}/bin/xrandr --output eDP-1 --brightness 2";
        };
    };

    systemd.user.timers."set-gamma" = lib.mkIf should-bright {
        wantedBy = [ "timers.target" ];

        timerConfig = {
        OnBootSec = "2m";
        OnUnitActiveSec = "2m";
        Unit = "set-gamma.service";
        };
    };
}