{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./oauth-redirect.nix
        ./cinnamon.nix
    ];

    # Foundation
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
    boot.loader.grub.useOSProber = true;
    
    networking.hostName = "nixos";
    networking.networkmanager.enable = true;
    
    time.timeZone = "America/New_York";
    
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };

    security.rtkit.enable = true;

    services.xserver.enable = true;
    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.xkb = {
        layout = "us";
        variant = "";
    };

    services.pulseaudio.enable = false;
    services.printing.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    nixpkgs.config.allowUnfree = true;

    system.stateVersion = "25.11";

    # Define user account.
    users.users.tetraketra = {
        isNormalUser = true;
        description = "TetraKetra";
        extraGroups = [ "networkmanager" "wheel" ];
    };

    # Define system packages.
    environment.systemPackages = with pkgs; [
        wget
        git
    ];

    # Define user packages.
    users.users.tetraketra.packages = with pkgs; [
        firefox
        github-desktop
        nemo
        vscode-with-extensions
        shutter
    ];
}
