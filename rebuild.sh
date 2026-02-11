rm /etc/nix/configuration.nix
ln ./configuration.nix /etc/nix/configuration.nix

nixos-rebuild switch