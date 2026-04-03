{ config, lib, inputs, pkgs-unstable, pkgs-stable, ... }:

let
    enable-on-targets = [ "hp-envy" ];
    should-bright = builtins.elem (builtins.getEnv "TARGET") enable-on-targets;
    command-bright = "xrandr --output eDP-1 --brightness 1.5";
in
{
    home.sessionVariables.DISPLAY = ":0";

    home.activation.setGamma = lib.mkIf should-bright ''
        ${pkgs-stable.xorg.xrandr}/bin/${command-bright}
    '';

    home.file.".config/systemd/user/set-gamma.service".text = lib.mkIf should-bright ''
        [Unit]
        Description=Set screen brightness

        [Service]
        Type=oneshot
        ExecStart=${pkgs-stable.xorg.xrandr}/bin/${command-bright}
    '';

    home.file.".config/systemd/user/set-gamma.timer".text = lib.mkIf should-bright ''
        [Unit]
        Description=Run set-gamma every 60s after boot

        [Timer]
        OnBootSec=15s
        OnUnitActiveSec=60s
        Unit=set-gamma.service

        [Install]
        WantedBy=timers.target
    '';
}
