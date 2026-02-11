# Setup.
set -e
REPO_HOME="$(git rev-parse --show-toplevel)"

# Move repo.
echo "🚚 Moving repo to \`/etc/nixos\`."
[ -f /etc/nixos ] && sudo mv /etc/nixos /etc/nixos.bak
sudo rm -rf /etc/nixos
sudo cp -r $REPO_HOME /etc/nixos
sudo cp /etc/nixos/hosts/$1/hardware-configuration.nix /etc/nixos/hardware-configuration.nix

# Move dotfiles.
echo "🔗 Linking dotfiles."
USER_HOME=$(eval echo "~$SUDO_USER")
ln -sf $REPO_HOME/dotfiles/.bashrc $USER_HOME/.bashrc
ln -sf $REPO_HOME/dotfiles/nemo-desktop-metadata $USER_HOME/.config/nemo/desktop-metadata

# Rebuild.
echo "🏗️  Rebuilding."
nixos-rebuild switch
dconf reset -f /org/gnome/desktop/interface/
dconf reset -f /org/cinnamon/desktop/applications/
cinnamon --replace >/dev/null 2>&1 &

# Final.
echo "✅ Complete!"