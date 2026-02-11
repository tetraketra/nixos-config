REPO_HOME="$(git rev-parse --show-toplevel)"

sudo mv /etc/nixos /etc/nixos.bak
sudo ln -sfn $REPO_HOME/hosts/$1/hardware-configuration.nix $REPO_HOME/hardware-configuration.nix
sudo ln -s $REPO_HOME /etc/nixos

sudo nixos-rebuild switch