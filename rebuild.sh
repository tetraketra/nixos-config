# Setup.
set -e
REPO_HOME="$(git rev-parse --show-toplevel)"

# Cleanup.
cleanup() {
    if [ -L "$REPO_HOME/hardware-configuration.nix" ]; then
        unlink "$REPO_HOME/hardware-configuration.nix"
    fi
}
trap cleanup EXIT

# Enable experimental features.
sudo cp /etc/nix/nix.conf /etc/nix/nix.conf.tmp
grep -qxF 'experimental-features = nix-command flakes' /etc/nix/nix.conf.tmp || \
    echo 'experimental-features = nix-command flakes' | sudo tee -a /etc/nix/nix.conf.tmp
sudo mv /etc/nix/nix.conf.tmp /etc/nix/nix.conf

# Link repo to `/etc/nixos`.
sudo mv /etc/nixos /etc/nixos.bak
sudo ln -sf $REPO_HOME/hosts/$1/hardware-configuration.nix $REPO_HOME/hardware-configuration.nix
sudo ln -s $REPO_HOME /etc/nixos

# Move dotfiles.
sudo ln -sf $REPO_HOME/dotfiles/.zshrc ~/.zshrc

# Rebuild.
sudo nixos-rebuild switch

# Cinnamon.
gsettings set org.cinnamon.desktop.interface gtk-theme "Mint-Y-Dark-Teal"
gsettings set org.cinnamon.desktop.wm.preferences theme "Mint-Y-Dark-Teal"
gsettings set org.cinnamon.desktop.interface icon-theme "Mint-L-Teal"
cinnamon --replace &