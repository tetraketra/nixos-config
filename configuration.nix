{ inputs, config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./oauth-redirect.nix
        ./cinnamon.nix
        ./default-apps.nix
        ./development.nix
        inputs.homne-manager.nixosModules.home-manager
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
    services.displayManager = {
        autoLogin.enable = true;
        autoLogin.user = "tetraketra";
    };

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

    system.stateVersion = "25.11";

    nixpkgs.config.allowUnfree = true;
    
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Define user account.
    programs.zsh.enable = true;
    users.users.tetraketra = {
        isNormalUser = true;
        description = "TetraKetra";
        extraGroups = [ "networkmanager" "wheel" ];
        shell = pkgs.zsh;
    };
    
    # Define system packages.
    environment.systemPackages = with pkgs; [
        nemo
        shutter
        wget
        zsh
        firefox
        vlc
        qalculate-gtk
        gimp2-with-plugins
        zsh
        zsh-z
        zsh-wd
        zsh-bd
        dust
        fastfetch
        neovide # I need to learn Vim keybinds at some point T>T
        home-manager
    ];
}
