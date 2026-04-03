{ config, lib, pkgs-stable, ... }:

let
    enable-on-targets = [ "hp-envy" ];
    should-bright = builtins.elem (builtins.getEnv "TARGET") enable-on-targets;
in
{
    systemd.user.services."set-gamma" = lib.mkIf should-bright {
        Unit.After = [ "graphical-session.target" ];
        Install.WantedBy = [ "graphical-session.target" ];

        Service = {
            Type = "oneshot";
            ExecStart = "${pkgs-stable.xorg.xrandr}/bin/xrandr --output eDP-1 --brightness 2";
        };        
    };

    systemd.user.timers."set-gamma" = lib.mkIf should-bright {
        Install.WantedBy = [ "timers.target" ];

        Timer = {
            OnBootSec = "2m";
            OnUnitActiveSec = "2m";
        };
    };
}