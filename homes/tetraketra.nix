{ config, inputs, pkgs-unstable, pkgs-stable, lib, ... }:

let
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
    
    pinta-pkg = import inputs.nixpkgs-pinta {
        system = pkgs-unstable.stdenv.hostPlatform.system;
    };
in
{
    home.packages = [
        pinta-pkg.pinta
    ];

    dconf.enable = true;
    dconf.settings = keybinds-generator [
        { binding = ["<Primary><Alt>f"]; command = "firefox"; name = "Launch Firefox (F)"; }
        { binding = ["<Primary><Alt>c"]; command = "qalculate-gtk -n"; name = "Launch Qalculate-GTK (C)"; }
        { binding = ["<Primary><Alt>q"]; command = "qalculate-gtk -n"; name = "Launch Qalculate-GTK (Q)"; }
        { binding = ["<Primary><Alt>b"]; command = "alacritty -e btop"; name = "Launch BTop (B)"; }
        { binding = ["<Primary><Alt>p"]; command = "pinta"; name = "Launch Pinta (P)"; }
        { binding = ["<Primary><Shift>s"]; command = "shutter -s"; name = "Launch Shutter (S)"; }
    ];
}
