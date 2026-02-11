# Setup.
set -e
REPO_HOME="$(git rev-parse --show-toplevel)"

# Link repo to `/etc/nixos`.
echo "🔗 Linking repo to \`/etc/nixos\`."
sudo mv /etc/nixos /etc/nixos.bak
sudo ln -s $REPO_HOME /etc/nixos
sudo ln -s $REPO_HOME/hosts/$1/hardware-configuration.nix /etc/nixos/hardware-configuration.nix

# Move dotfiles.
echo "🔗 Linking dotfiles to \`~\`."
sudo ln -sf $REPO_HOME/dotfiles/.zshrc ~/.zshrc

# Rebuild.
echo "🏗️  Rebuilding."
nixos-rebuild switch --impure

# Cinnamon.
echo "🫚 Updating cinnamon."
gsettings set org.cinnamon.desktop.interface gtk-theme "Mint-Y-Dark-Teal"
gsettings set org.cinnamon.desktop.wm.preferences theme "Mint-Y-Dark-Teal"
gsettings set org.cinnamon.desktop.interface icon-theme "Mint-L-Teal"
cinnamon --replace &

# Final.
echo "✅ Complete!"