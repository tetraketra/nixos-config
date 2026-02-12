{ inputs, lib, pkgs, ... }:
{
    home = {
        # packages = with pkgs; [
        #     hello
        # ];

        username = "tetraketra";
        homeDirectory = "/home/tetraketra";

        stateVersion = "23.11";
    };
}
