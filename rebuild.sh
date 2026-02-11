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
echo "🔗 Linking dotfiles."
sudo ln -sf $REPO_HOME/dotfiles/.bashrc ~/.bashrc

# Rebuild.
echo "🏗️  Rebuilding."
nixos-rebuild switch
dconf reset -f /org/gnome/desktop/interface/

# Final.
echo "✅ Complete!"