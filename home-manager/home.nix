{ inputs, lib, pkgs, ... }:
{
    home = {
        packages = with pkgs; [
            hello
        ];

        # and so on
    };
}
