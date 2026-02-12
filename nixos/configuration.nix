{ inputs, config, pkgs-stable, pkgs-unstable, host-selection, ... }:

{
    imports = [
        host-selection
        ./modules/oauth-redirect.nix
        ./modules/cinnamon.nix
        ./modules/default-apps.nix
        ./modules/development.nix
        inputs.home-manager.nixosModules.home-manager
    ];

    # Foundation
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
    boot.loader.grub.useOSProber = true;

    networking.hostName = "nixos";
    networking.networkmanager.enable = true;

    time.timeZone = "America/New_York";

    i18n.defaultLocale = "en_US.UTF-8";

    security.rtkit.enable = true;

    services.xserver.enable = true;
    services.xserver.displayManager.lightdm.enable = true;
    services.displayManager = { # The location of these was changed recently.
        autoLogin.enable = true;
        autoLogin.user = "tetraketra";
    };

    services.xserver.xkb = {
        layout = "us";
        variant = "";
    };

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
        shell = pkgs-stable.zsh;
    };
    
    # Define system packages.
    environment.systemPackages = (with pkgs-stable; [
        btop
        dconf
        dconf-editor
        dust
        emote
        fastfetch
        firefox
        nemo
        neovide
        nvtop
        shutter
        wget
        zsh
        zsh-bd
        zsh-wd
        zsh-z
    ]) ++ (with pkgs-unstable; [
        # ...
    ])
    ;

    # Home Manager
    home-manager = {
        extraSpecialArgs = { 
            inherit inputs pkgs-unstable pkgs-stable; 
        };

        useGlobalPkgs = true;

        users.tetraketra = {
            imports = [ ../homes/tetraketra.nix ];
            home = {
                username = "tetraketra";
                homeDirectory = "/home/tetraketra";
                stateVersion = "23.11";
            };
        };
    };
}
