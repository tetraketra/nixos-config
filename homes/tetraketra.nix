{ config, pkgs, lib, ... }:

let
  keybinds-generator = bindlist:
    let
      custom-names = map (i: "custom${toString i}") (pkgs.lib.lists.range 0 (builtins.length bindlist - 1));
      zipped = pkgs.lib.lists.zipListsWith (n: b: { name = n; bind = b; }) custom-names bindlist;
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
in
{
    dconf.enable = true;
    dconf.settings = keybinds-generator [
        { binding = ["<Primary><Alt>f"]; command = "firefox"; name = "Launch Firefox (F)"; }
        { binding = ["<Primary><Alt>c"]; command = "qalculate-gtk -n"; name = "Launch Qalculate-GTK (C)"; }
        { binding = ["<Primary><Alt>q"]; command = "qalculate-gtk -n"; name = "Launch Qalculate-GTK (Q)"; }
    ];
}
