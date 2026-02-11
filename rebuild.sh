# Setup
set -e
REPO_HOME="$(git rev-parse --show-toplevel)"

# Link repo to `/etc/nixos`.
sudo mv /etc/nixos /etc/nixos.bak
sudo ln -sf $REPO_HOME/hosts/$1/hardware-configuration.nix $REPO_HOME/hardware-configuration.nix
sudo ln -s $REPO_HOME /etc/nixos

# Rebuild.
sudo nixos-rebuild switch

# Cinnamon
gsettings set org.cinnamon.desktop.interface gtk-theme "Mint-Y-Dark-Teal"
gsettings set org.cinnamon.desktop.wm.preferences theme "Mint-Y-Dark-Teal"
gsettings set org.cinnamon.desktop.interface icon-theme "Mint-L-Teal"
cinnamon --replace &

# Cleanup
cleanup() {
    if [ -L "$REPO_HOME/hardware-configuration.nix" ]; then
        unlink "$REPO_HOME/hardware-configuration.nix"
    fi
}
trap cleanup EXIT