{ config, lib, pkgs-stable, ... }:

let
    version = builtins.replaceStrings ["\n"] [""] (builtins.readFile ../../.host-selection);

    enable-on-hosts = [ "hp-envy" ];
    should-bright = builtins.elem version enable-on-hosts;
in
{
    builtins.trace version
    builtins.trace version should-bright

    systemd.timers."set-gamma" = lib.mkIf {
        wantedBy = [ "timers.target" ];
        timerConfig = {
            OnBootSec = "5m";
            OnUnitActiveSec = "5m";
            Unit = "set-gamma.service";
        };
    };

    systemd.services."set-gamma" = lib.mkIf {
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