REPO_HOME="$(git rev-parse --show-toplevel)"

sudo mv /etc/nixos /etc/nixos.bak
sudo ln -s $REPO_HOME /etc/nixos
sudo ln -s $REPO_HOME/hosts/$1/hardware-configuration.nix /etc/nixos/hardware-configuration.nix
sudo nixos-rebuild switch