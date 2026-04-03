{ config, lib, inputs, pkgs-unstable, pkgs-stable, ... }:

{
    home.file.".zshrc".source = ../../dotfiles/.zshrc;
    home.file.".bashrc".source = ../../dotfiles/.bashrc;
    home.file.".alacritty.toml".source = ../../dotfiles/.alacritty.toml;
    xdg.configFile."nemo".source = ../../dotfiles/nemo;
    xdg.configFile."vesktop/settings".source = ../../dotfiles/vesktop;
}
