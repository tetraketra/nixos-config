# Setup
set -e
REPO_HOME="$(git rev-parse --show-toplevel)"

# Link repo to `/etc/nixos`.
sudo mv /etc/nixos /etc/nixos.bak
sudo ln -sf $REPO_HOME/hosts/$1/hardware-configuration.nix $REPO_HOME/hardware-configuration.nix
sudo ln -s $REPO_HOME /etc/nixos

# Rebuild.
sudo nixos-rebuild switch

# Cleanup
unlink $REPO_HOME/hardware-configuration.nix