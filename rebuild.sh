# Setup.
set -e
REPO_HOME="$(git rev-parse --show-toplevel)"

# Link repo to `/etc/nixos`.
echo "🚚 Moving repo to \`/etc/nixos\`."
[ -f /etc/nixos ] && sudo mv /etc/nixos /etc/nixos.bak
sudo rm -rf /etc/nixos
sudo cp -r $REPO_HOME /etc/nixos
sudo cp /etc/nixos/hosts/$1/hardware-configuration.nix /etc/nixos/hardware-configuration.nix

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