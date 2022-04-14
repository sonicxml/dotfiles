#!/bin/zsh

echo "Please enter your name: "
read "name"
echo "Please enter your email: "
read "email"
echo "What would you like to call your default venv?"
read "venv"

echo "Install all AppStore Apps first!"
# no solution to automate AppStore installs
# Install 1Password
# Install Amphetamine
# Install NextDNS
# Install Scroll
# Install Vimari
read -k1 "?Press any key to continue... "

echo "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/$USER/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
brew tap homebrew/cask-fonts

echo "Installing core apps"
export HOMEBREW_NO_AUTO_UPDATE=1
brew install --cask font-source-code-pro
brew install --cask font-source-code-pro-for-powerline
brew install --cask font-hasklig
brew install --cask karabiner-elements
brew install --cask kitty
brew install --cask rectangle
brew install --cask spotify
# Uncomment if desired
# brew install --cask usb-overdrive
# brew install --cask spotify-notifications
# brew install --cask docker
brew install --cask firefox
brew install --cask google-chrome

# Consider installing Little Snitch and/or Micro Snitch
# https://www.obdev.at/products/littlesnitch/order.html

# Normal brew installations
echo "Installing standard brew tools"
brew install bat
brew install ctags
brew install exa
brew install fd
brew install fzf
# brew install git-delta
brew install neovim
brew install node
brew install ripgrep
brew install tmux
brew install wget
brew install zoxide
brew install zplug

# Dev-specific brew installations
echo "Installing brew developer tools"
brew install python@3.8
export PATH="/usr/local/opt/python@3.8/bin:$PATH"
python3 -m pip install virtualenvwrapper
# brew install go
# brew install protobuf
# brew install postgresql
# brew install rustup
# brew install sqlite

echo "Creating SSH Keys"
# ssh-keygen -t ed25519 -C $email -q -N ""
# ssh-keygen -t rsa -b 4096 -C $email -q -N ""

echo "Disabling key repeat for certain applications"
defaults write co.zeit.hyper ApplePressAndHoldEnabled -bool false
defaults write com.jetbrains.pycharm.ce ApplePressAndHoldEnabled -bool false
defaults write com.jetbrains.pycharm ApplePressAndHoldEnabled -bool false

echo "Setting up all dotfiles"
# Install Vim-plug for vim and neovim
# Vim
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi;
# Neovim
if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]; then
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi;

# Setup dotfiles, create symlinks
if [ ! -d .git ] || [ "$PWD" != "/Users/$USER/.dotfiles" ]; then
    echo "Dotfiles repo either doesn't exist or is in an unexpected location."
    echo "Cloning into ~/.dotfiles"
    git clone https://github.com/sonicxml/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
fi;

# All the replacements
sed -i '' "s/name = NAME/name = $name/" shell/git/.gitconfig
sed -i '' "s/email = EMAIL/email = $email/" shell/git/.gitconfig
sed -i '' "s/VENV/$venv/g" editor/.config/nvim/coc-settings.json
sed -i '' "s/VENV/$venv/g" editor/.config/nvim/init.vim
sed -i '' "s/USERNAME/$USER/g" editor/.vimrc
sed -i '' "s/USERNAME/$USER/g" editor/.config/nvim/coc-settings.json
sed -i '' "s/BREW_LOC/\/usr\/local/g" shell/zsh/.zshrc

mkdir ~/.config
for dir in */.config/*/
do
    dir=${dir%*/}  # Remove trailing /
    ln -s "/Users/$USER/.dotfiles/$dir" ~/.config/
done
# ln -s /Users/$USER/.dotfiles/editor/.vimrc ~/.vimrc
ln -s /Users/$USER/.dotfiles/gui/intellij/.ideavimrc ~/.ideavimrc
ln -s /Users/$USER/.dotfiles/shell/.fzf.bash ~/.fzf.bash
ln -s /Users/$USER/.dotfiles/shell/.fzf.zsh ~/.fzf.zsh
ln -s /Users/$USER/.dotfiles/shell/git/.gitconfig ~/.gitconfig
ln -s /Users/$USER/.dotfiles/shell/tmux/.tmux.conf ~/.tmux.conf
ln -s /Users/$USER/.dotfiles/shell/zsh/.zshrc ~/.zshrc
ln -s /Users/$USER/.dotfiles/shell/zsh/.p10k.zsh ~/.p10k.zsh

# Create python venv
export WORKON_HOME=~/.virtualenvs
export PROJECT_HOME=~/dev
export VIRTUALENVWRAPPER_PYTHON=/usr/local/opt/python@3.8/bin/python3.8
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
. /usr/local/bin/virtualenvwrapper.sh

mkvirtualenv $venv
pip install black isort jedi pylint

