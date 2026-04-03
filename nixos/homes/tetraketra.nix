{ config, lib, inputs, pkgs-unstable, pkgs-stable, ... }:

let
    # Set Desktop Keybinds
    keybinds-generator = bindlist:
        let
            custom-names = map (i: "custom${toString i}") (pkgs-stable.lib.lists.range 0 (builtins.length bindlist - 1));
            zipped = pkgs-stable.lib.lists.zipListsWith (n: b: { name = n; bind = b; }) custom-names bindlist;
        in {
            "org/cinnamon/desktop/keybindings" = { custom-list = custom-names; };
        } // builtins.listToAttrs (
            map (item: {
                name = "org/cinnamon/desktop/keybindings/custom-keybindings/${item.name}";
                value = {
                    binding = item.bind.binding;
                    command = item.bind.command;
                    name = item.bind.name;
                };
            }) zipped
        );


    # Fix Brightness
    enable-on-targets = [ "hp-envy" ];
    should-bright = builtins.elem (builtins.getEnv "TARGET") enable-on-targets;
    command-bright = "xrandr --output eDP-1 --brightness 1.5";

    files = [
        ../modules/pinta.nix
    ];

    configs = map (f: import f { inherit config lib inputs pkgs-stable pkgs-unstable; }) files;
    merged = lib.foldl (a: b: a // b) {} configs;
in
merged // {
    # Set Desktop Keybinds
    dconf.enable = true;
    dconf.settings = keybinds-generator [
        { binding = ["<Primary><Alt>f"]; command = "firefox"; name = "Launch Firefox (F)"; }
        { binding = ["<Primary><Alt>c"]; command = "qalculate-gtk -n"; name = "Launch Qalculate-GTK (C)"; }
        { binding = ["<Primary><Alt>q"]; command = "qalculate-gtk -n"; name = "Launch Qalculate-GTK (Q)"; }
        { binding = ["<Primary><Alt>b"]; command = "alacritty -e btop"; name = "Launch BTop (B)"; }
        { binding = ["<Primary><Alt>p"]; command = "pinta"; name = "Launch Pinta (P)"; }
        { binding = ["<Primary><Shift>s"]; command = "shutter -s"; name = "Launch Shutter (S)"; }
    ];

    # Link Dotfiles
    home.file.".zshrc".source = ../../dotfiles/.zshrc;
    home.file.".bashrc".source = ../../dotfiles/.bashrc;
    home.file.".alacritty.toml".source = ../../dotfiles/.alacritty.toml;
    xdg.configFile."nemo".source = ../../dotfiles/nemo;

    # Startup Apps
    xdg.configFile."autostart/vesktop.desktop".text = ''
        [Desktop Entry]
        Type=Application
        Exec=vesktop
        Hidden=false
        NoDisplay=false
        X-GNOME-Autostart-enabled=true
        Name=Vesktop
    '';

    xdg.configFile."autostart/firefox.desktop".text = ''
        [Desktop Entry]
        Type=Application
        Exec=firefox
        Hidden=false
        NoDisplay=false
        X-GNOME-Autostart-enabled=true
        Name=Firefox
    '';

    xdg.configFile."autostart/github-desktop.desktop".text = ''
        [Desktop Entry]
        Type=Application
        Exec=github-desktop
        Hidden=false
        NoDisplay=false
        X-GNOME-Autostart-enabled=true
        Name=GitHub Desktop
    '';


    # Fix Brightness
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
