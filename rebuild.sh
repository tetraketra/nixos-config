# Setup.
set -e
REPO_HOME="$(git rev-parse --show-toplevel)"

# Cleanup.
echo "🗑️  Defining cleanup on-exit step."
cleanup() {
    if [ -L "$REPO_HOME/hardware-configuration.nix" ]; then
        unlink "$REPO_HOME/hardware-configuration.nix"
    fi
}
trap cleanup EXIT

# Link repo to `/etc/nixos`.
echo "🔗 Linking repo to \`/etc/nixos\`."
unlink /etc/nixos
sudo ln -sf $REPO_HOME/hosts/$1/hardware-configuration.nix $REPO_HOME/hardware-configuration.nix
git add $REPO_HOME/hardware-configuration.nix
sudo ln -s $REPO_HOME /etc/nixos

# Move dotfiles.
echo "🔗 Linking dotfiles to \`~\`."
sudo ln -sf $REPO_HOME/dotfiles/.zshrc ~/.zshrc

# Rebuild.
echo "🏗️  Rebuilding."
nixos-rebuild switch

# Cinnamon.
echo "🫚 Updating cinnamon."
gsettings set org.cinnamon.desktop.interface gtk-theme "Mint-Y-Dark-Teal"
gsettings set org.cinnamon.desktop.wm.preferences theme "Mint-Y-Dark-Teal"
gsettings set org.cinnamon.desktop.interface icon-theme "Mint-L-Teal"
cinnamon --replace &

# Final.
echo "✅ Complete!"