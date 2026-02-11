chmod +w /etc/nixos/configuration.nix
rm /etc/nixos/configuration.nix
sudo ln -sf ./configuration.nix /etc/nixos/configuration.nix

nixos-rebuild switch 