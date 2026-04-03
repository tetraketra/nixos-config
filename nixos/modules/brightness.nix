{ config, lib, pkgs-stable, ... }:

let
    enable-on-targets = [ "hp-envy" ];
    should-bright = builtins.elem (builtins.getEnv "TARGET") enable-on-targets;
in
{
    systemd.services.set-gamma = {
        description = "My periodic task service";
        serviceConfig.Type = "oneshot";
        script = ''
            ${pkgs-stable.xorg.xrandr}/bin/xrandr --output eDP-1 --brightness 2
        '';
    };

    systemd.timers.set-gamma = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
        OnBootSec = "15s";
        OnUnitActiveSec = "60s";
        Unit = "set-gamma.service";
    };
    };

}